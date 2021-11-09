//
//  Logic.swift
//  Gom_mvvm
//
//  Created by sangheon on 2021/11/09.
//

import Foundation

class Service {
    
    let repository = Repository()
    
    func fetchNow(onCompleted:@escaping (Model) -> Void) {
        repository.fetchNow { entity in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
            
            guard let now = formatter.date(from: entity.currentDateTime) else { return }
            let model = Model(currentDateTime: now)
            onCompleted(model)
        }
    }
    
    
    func onYesterDay(now:Date) -> Date {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now) else {
            return now
        }
        return yesterday
    }
    
    func onNow() {
        
    }
    
    func onTomorrow(now:Date) -> Date {
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: +1, to: now) else {
            return now
        }
        return tomorrow
    }
    
    
}
