//
//  StockRepository.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/23.
//

import Combine

protocol StockRepository {
    func fetchStockPublisher(keywords:String) -> AnyPublisher<StockResult,Error>
    func fetchTimeSeriesPublish(keywords:String) -> AnyPublisher<TimeSeriesMonthlyAdjusted,Error> 
}
