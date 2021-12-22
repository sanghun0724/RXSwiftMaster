//
//  Article.swift
//  RxSwiftPractice
//
//  Created by sangheon on 2021/12/19.
//

import Foundation

struct ArticleResponse:Codable{
    let status:String
    let totalResults:Int
    let articles:[Article]
}

struct Article:Codable {
    let auth:String?
    let title:String?
    let description:String?
    let url:String?
    let urlToImage:String?
    let publishedAt:String?
}

