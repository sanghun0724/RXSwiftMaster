//
//  ApiController.swift
//  IGif
//
//  Created by sangheon on 2021/10/24.
//

import Foundation
import RxSwift
import SwiftyJSON

class ApiController {
    
    static let shared = ApiController()
    
    private let apiKey = ""
    
    func search(text:String) -> Observable<[JSON]> {
        let url = URL(string: "")!
        var request = URLRequest(url: url)
        let keyQueryItem = URLQueryItem(name: "apiKey", value: apiKey)
        let serchQueryItem = URLQueryItem(name: "q", value: text)
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)
        
        urlComponents?.queryItems = [serchQueryItem,keyQueryItem]
        
        request.url = urlComponents!.url
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return Observable.just([])
    }
}
