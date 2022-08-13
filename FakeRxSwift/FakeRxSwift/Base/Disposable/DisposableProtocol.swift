//
//  DisposableProtocol.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/09.
//

import Foundation


// Disposable는 사용 후 버리는 리소스를 말하며, error나 completed 등으로 더이상 구독하지 않는 상태가 되었을 떄 정리하도록 dispose함수를 정의 
protocol Disposable {
    //dispose 상태 시 호출
    func dispose()
}
