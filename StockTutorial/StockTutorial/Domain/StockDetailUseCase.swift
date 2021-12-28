//
//  StockDetailUseCase.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/28.
//

import Foundation
import Combine

class StockDetailUseCase {
    
    func fetchTimeSeriesPublish(keywords:String) -> AnyPublisher<TimeSeriesMonthlyAdjusted,Error> {
        return stockRepository.fetchTimeSeriesPublish(keywords: keywords)
    }
    
    private let stockRepository: StockRepository
    
    init(stockRepository:StockRepository) {
        self.stockRepository = stockRepository
    }
}
