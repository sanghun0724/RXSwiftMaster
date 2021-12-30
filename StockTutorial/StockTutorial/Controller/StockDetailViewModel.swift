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
    @Published var monthInfos:[MonthInfo] = []
    
    let usecase:StockDetailUseCase
    
    func viewDidLoad(symbol:String) {
        loading = true
        usecase.fetchTimeSeriesPublish(keywords: symbol).sink { completion in
            self.loading = false
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
        bind()
    }
    func bind() { // time시리즈 데이터 감시하고 있다가 바뀌면 monthinfo도 업데이트
        $timeSeriesMonthlyAdjusted.sink { (timeSeriesMonthlyAdjusted) in
            guard let timeSeriesMonthlyAdjusted = timeSeriesMonthlyAdjusted else { return }
            self.monthInfos = timeSeriesMonthlyAdjusted.generateMonthInfos()
        }.store(in: &subscriber)
    }
    
}
