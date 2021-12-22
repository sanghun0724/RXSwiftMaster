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
//class stubArticleService:ArticleServiceProtocol {
//    func fetchNews() -> Observable<[Article]> {
//        return Observable.create {(observer) -> Disposable in
//
//            Article(auth: "dummy", title: "dummy", description: "dummy", url: "dummy", urlToImage: "dummy", publishedAt: "dummy")
//            Article(auth: "dummy", title: "dummy", description: "dummy", url: "dummy", urlToImage: "dummy", publishedAt: "dummy")
//            Article(auth: "dummy", title: "dummy", description: "dummy", url: "dummy", urlToImage: "dummy", publishedAt: "dummy")
//            Article(auth: "dummy", title: "dummy", description: "dummy", url: "dummy", urlToImage: "dummy", publishedAt: "dummy")
//            return Disposables.create()
//        }
//    }
//}

