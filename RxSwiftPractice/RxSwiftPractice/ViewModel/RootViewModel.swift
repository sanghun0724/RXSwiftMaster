//
//  RootViewModel.swift
//  RxSwiftPractice
//
//  Created by sangheon on 2021/12/19.
//

import Foundation
import RxSwift

final class RootViewModel {
    let title = "sangheon News"
    
    private let articleService:ArticleServiceProtocol
    
    init(articleService:ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    func fetchArticles() -> Observable<[Article]> {
        articleService.fetchNews()
    }
    
}
