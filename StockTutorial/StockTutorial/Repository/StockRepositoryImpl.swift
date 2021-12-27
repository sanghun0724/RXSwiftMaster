//
//  StockRepositoryImpl.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/23.
//

import Foundation
import Combine

class StockRepositoryImpl:StockRepository {
    
    enum StockRepositoryError: Error{
        case encoding
        case bad_url
    }
    
    
    let apiKey:String = "H4ZRG44U4X1T6VSV"
    let decoder = JSONDecoder()
    
    //URLString은 띄어쓰기가 포함안됨 -> 띄어쓰기가 올것을 대비해 encoding하는 작업이 필요
    func fetchStockPublisher(keywords: String) -> AnyPublisher<StockResult, Error> {
        //1 parseQuerySting
        let queryResult = parseqQueryString(text: keywords)
        var query = ""
        switch queryResult {
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        case .success(let value):
            query = value
        }
        
        //2 parseURL
        let urlResult = parseURL(urlString:  "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(query)&apikey=\(apiKey)")
        
        switch urlResult {
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        case .success(let url):
            return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }.decode(type: StockResult.self, decoder: decoder).receive(on: RunLoop.main).eraseToAnyPublisher()
        }
    }
    
    func fetchTimeSeriesPublish(keywords:String) -> AnyPublisher<TimeSeriesMonthlyAdjusted,Error> {
        //1
        let queryResult = parseqQueryString(text: keywords)
        var query = ""
        
        switch queryResult {
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        case .success(let value):
            query = value
        }
        
        let urlResult = parseURL(urlString: "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(query)&apikey=\(apiKey)")
        
        switch urlResult {
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        case .success(let url):
            return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }.decode(type: TimeSeriesMonthlyAdjusted.self, decoder: decoder).receive(on: RunLoop.main).eraseToAnyPublisher()
        }
    }
    
    private func parseURL(urlString:String) -> Result<URL,Error> {
        if let url = URL(string: urlString) {
            return .success(url)
        } else  {
            let error:StockRepositoryError = .bad_url
            return .failure(error)
        }
    }
    
    private func parseqQueryString(text:String) -> Result<String,Error> {
        if let query = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return .success(query)
        } else {
            let error:StockRepositoryError = .encoding
            return .failure(error)
        }
    }
}


//이것도 코드중복아니야 ? nono 왜냐하면 우리가 중복되게 하지 않으려는건 Business Logic임 로직을 단순화시키고 수정을 손쉽게 만듬 템플릿코드같은게 중복되는거는 쩔수없는거고
