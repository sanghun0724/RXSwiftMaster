//
//  ViewModel.swift
//  Gom_mvvm
//
//  Created by sangheon on 2021/11/09.
//

import Foundation

class ViewModel {
    
    var onUpdated: () -> Void = {}
    
    var dateTimeToString:String = "Loding.."
    
    let service = Service()
    
    func viewDidLoad() {
        service.fetchNow { [weak self] model in
            guard let self = self else { return }
            let dateString = self.dateToString(date: model.currentDateTime)
            self.dateTimeToString = dateString
        }
    }
    
    private func dateToString(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: date)
    }
}
