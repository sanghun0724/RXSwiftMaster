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
        guard let keywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { //띄어쓰기 처리
            let error:StockRepositoryError = .encoding
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }.decode(type: StockResult.self, decoder: decoder).receive(on: RunLoop.main).eraseToAnyPublisher()
    }
    
    func fetchTimeSeriesPublish(keywords:String) -> AnyPublisher<TimeSeriesMonthlyAdjusted,Error> {
        guard let keywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            let error:StockRepositoryError = .encoding
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(keywords)&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            let error:StockRepositoryError = .bad_url
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }.decode(type: TimeSeriesMonthlyAdjusted.self, decoder: decoder).receive(on: RunLoop.main).eraseToAnyPublisher()
        
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
