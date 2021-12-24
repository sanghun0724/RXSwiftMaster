//
//  StockUseCase.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/23.
//

import Foundation
import Combine

class StockUseCase {
    
    private let stockRepository:StockRepository
    
    func fetchStocksPublisher(keyword:String) -> AnyPublisher<StockResult,Error> {
        return stockRepository.fetchStockPublisher(keywords: keyword)
    }
    
    init(stockRepository:StockRepository) {
        self.stockRepository = stockRepository
    }
}
