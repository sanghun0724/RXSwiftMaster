//
//  URLSession+Rx.swift
//  IGif
//
//  Created by sangheon on 2021/10/24.
//

import Foundation
import RxSwift
import SwiftyJSON
import UIKit

fileprivate var internalCache = [String:Data]()

public enum RxURLSessionError:Error {
    case unknown
    case invalidResponse(resonse: URLResponse)
    case requestFailed(resonse:HTTPURLResponse,data:Data?)
    case deserializationFailed
}
//우리가 쓸 Data Observable만 타겟으로
extension ObservableType where Element == (HTTPURLResponse, Data) {
    func cache() -> Observable<Element> {
        return self.do(onNext: { (response,data) in
            if let url = response.url?.absoluteString, 200..<300 ~= response.statusCode {
                internalCache[url] = data
            }
        })
    }
}



//Reactive extension은 .rx 키워드를 URLSesstion에 붙일 수 있게 해준다.
extension Reactive where Base: URLSession {
    //어떤놈이 반환되어야하는지 알수 있다
    func response(request:URLRequest) -> Observable<(HTTPURLResponse,Data)> {
        return Observable.create{ observer in
            let task = self.base.dataTask(with: request) { (data,response,error) in
                guard let response = response, let data = data else {
                    observer.on(.error(error ?? RxURLSessionError.unknown))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.on(.error(RxURLSessionError.invalidResponse(resonse: response)))
                    return
                }
                observer.onNext((httpResponse,data))
                observer.on(.completed)
            }
            
            task.resume() //요청 trigger
            return Disposables.create(with: task.cancel) //disoposable 하면 task 끝내서 메모리 leak 막기
        }//저렇게 결과값 함으로써 URLResoponse는 요청이 Data의 반환을 받기까지 성공적으로 진행되는것을 확인하기 위해 대기하게 된다.
    }
    //여기서 요청을 보내고 해당 요청에 대한 응답을 받는 것은 Observable의 유일한 용도이다. 따라서 observable이(완전 종료되지 않고) 계속 살아있는 상태로 또다른 요청에 대해 작동하는것은 말이 안된다. 이런 작동은 소켓통신 같은 것에 더 적합하다.
    
    func data(request:URLRequest) -> Observable<Data> {
        
        if let url = request.url?.absoluteString, let data = internalCache[url] {
            return Observable.just(data)
        }
        
        return response(request: request).cache().map { (response,data) -> Data in
            if 200 ..< 300 ~= response.statusCode {
                return data
            } else {
                throw RxURLSessionError.requestFailed(resonse: response, data: data)
            }
        }
    }
    
    func string(request:URLRequest) -> Observable<String> {
        return data(request: request).map { d in
            return String(data: d, encoding: .utf8) ?? ""
        }
    }
    
    func json(request:URLRequest) -> Observable<JSON> {
        return data(request: request).map { d in
            return try JSON(data: d)
        }
    }
    
    func image(request:URLRequest) -> Observable<UIImage> {
        return data(request: request).map { d in
            return UIImage(data: d) ?? UIImage()
        }
    }
    //map과 같은 몇몇 RxSwift의 연산자들은 process overhead를 피하기 위해 알아서 적절히 조합되어 map의 다중체인이 단일 호출로 최적화된다.
}
