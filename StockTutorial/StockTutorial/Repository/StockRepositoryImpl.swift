//
//  StockRepositoryImpl.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/23.
//

import Foundation
import Combine

class StockRepositoryImpl:StockRepository {
    
    let apiKey:String = "H4ZRG44U4X1T6VSV"
    let decoder = JSONDecoder()
    
    func fetchStockPublisher(keywords: String) -> AnyPublisher<StockResult, Error> {
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(apiKey)"
        
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }.decode(type: StockResult.self, decoder: decoder).receive(on: RunLoop.main).eraseToAnyPublisher()
    }
}
