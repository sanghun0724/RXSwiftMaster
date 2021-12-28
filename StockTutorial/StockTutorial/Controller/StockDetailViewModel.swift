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
        
    }
    
    init(usecase:StockDetailUseCase) {
        self.usecase = usecase
        super.init()
    }
    
}
