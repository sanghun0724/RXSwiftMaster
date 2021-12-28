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
    
    let usecase:StockDetailUseCase
    
    func viewDidLoad(symbol:String) {
        usecase.fetchTimeSeriesPublish(keywords: symbol).sink { completion in
            switch completion {
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            case .finished: break;
            }
        } receiveValue: { value in
            self.timeSeriesMonthlyAdjusted = value
        }.store(in: &subscriber)
    }
    
    init(usecase:StockDetailUseCase) {
        self.usecase = usecase
        super.init()
    }
    
}
