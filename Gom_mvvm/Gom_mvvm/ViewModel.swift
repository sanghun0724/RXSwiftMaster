//
//  ViewModel.swift
//  Gom_mvvm
//
//  Created by sangheon on 2021/11/09.
//

import Foundation

class ViewModel {
    
    var onUpdated: () -> Void = {}
    //With View
    //Model(Date)Service - > ViewModel(String)
    var dateTimeString:String = "Loding.." //화면에 보여줘야할 값 // 뷰를위한 모델: viewModel
    {
        didSet {
            onUpdated()
        }
    }
    let service = Service()
    
    private func dateToString(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: date)
    }
    func reload() {
        service.fetchNow { [weak self] model in
            guard let self = self else { return }
            let dateString = self.dateToString(date: model.currentDateTime)
            self.dateTimeString = dateString
        }
    }
    
    func moveDay(day: Int) {
        service.moveDay(day: day)
        dateTimeString = dateToString(date: service.currentModel.currentDateTime)
    }
}

