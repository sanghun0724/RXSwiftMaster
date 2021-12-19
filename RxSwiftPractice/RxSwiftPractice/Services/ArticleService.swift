//
//  ArticleService.swift
//  RxSwiftPractice
//
//  Created by sangheon on 2021/12/19.
//

import Foundation
import Alamofire
import RxSwift

protocol ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]>
}

//dummy Test!!!!! using protocol
class stubArticleService:ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]> {
        return Observable.create {(observer) -> Disposable in
            
            Article(auth: "dummy", title: "dummy", description: "dummy", url: "dummy", urlToImage: "dummy", publishedAt: "dummy")
            Article(auth: "dummy", title: "dummy", description: "dummy", url: "dummy", urlToImage: "dummy", publishedAt: "dummy")
            Article(auth: "dummy", title: "dummy", description: "dummy", url: "dummy", urlToImage: "dummy", publishedAt: "dummy")
            Article(auth: "dummy", title: "dummy", description: "dummy", url: "dummy", urlToImage: "dummy", publishedAt: "dummy")
            return Disposables.create()
        }
    }
}

class ArticleSerivce:ArticleServiceProtocol {
    
    func fetchNews() -> Observable<[Article]> {
        return Observable.create {(observer) -> Disposable in
            
            self.fetchNews() { (error,articles) in
                if let error = error {
                    observer.onError(error)
                }
                
                if let articles = articles{
                    observer.onNext(articles)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    
    
    private func fetchNews(completion:@escaping ((Error?,[Article]?) -> Void)) {
        let urlString = "https://newsapi.org/v2/everything?q=apple&from=2021-12-18&to=2021-12-18&sortBy=popularity&apiKey=ddef889b3d014a5c9c0d342ac352c023"
        
        guard let url = URL(string: urlString) else { return completion(NSError(domain: "sangheon", code: 404, userInfo: nil),nil)}
        
        let request = AF.request(url,method: HTTPMethod.get,parameters: nil,encoding: JSONEncoding.default,headers: nil,interceptor: nil,requestModifier: nil)
            .responseDecodable(of: ArticleResponse.self) { response in
                if let error = response.error {
                    return completion(error,nil)
                }
                
                if let article = response.value?.articles {
                    return completion(nil,article)
                }
            }
    }
}
