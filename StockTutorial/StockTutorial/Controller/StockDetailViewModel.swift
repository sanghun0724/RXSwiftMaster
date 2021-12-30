//
//  StockDetailViewModel.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/28.
//

import Foundation
import Combine

class StockDetailViewModel:BaseViewModel {
    @Published var loading = false
    @Published var errorMessage:String?
    @Published var timeSeriesMonthlyAdjusted:TimeSeriesMonthlyAdjusted?
    @Published var stock:Stock?
  
    let usecase:StockDetailUseCase
    
    func viewDidLoad(symbol:String,stock: Stock) {
        self.stock = stock
        loading = true
        usecase.fetchTimeSeriesPublish(keywords: symbol).sink { completion in
            self.loading = false
            switch completion {
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            case .finished: break;
            }
        } receiveValue: { value in
            var timeSeriesMonthlyAdjusted = value //받아오고
            timeSeriesMonthlyAdjusted.generateMonthInfos() //model에 monthinfo추가
            self.timeSeriesMonthlyAdjusted = timeSeriesMonthlyAdjusted
        }.store(in: &subscriber)
    }
    
    init(usecase:StockDetailUseCase) {
        self.usecase = usecase
        super.init()
    }
    
}
