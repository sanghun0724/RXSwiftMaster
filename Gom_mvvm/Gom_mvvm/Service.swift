//
//  Logic.swift
//  Gom_mvvm
//
//  Created by sangheon on 2021/11/09.
//

import Foundation
//핵심 비지니스 로직 담당 (ex) moveDay) With Model 
class Service {
    
    let repository = Repository()
    
    var currentModel = Model(currentDateTime: Date())
    
    func fetchNow(onCompleted:@escaping (Model) -> Void) {
        //Entity(json)->Repo(json)-> Service(Date)(Model)
        repository.fetchNow { [weak self]entity in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
            
            guard let now = formatter.date(from: entity.currentDateTime) else { return }
            let model = Model(currentDateTime: now)
            self?.currentModel = model
            onCompleted(model)
        }
    }
    
    
    func moveDay(day:Int) {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: day, to: currentModel.currentDateTime) else {
            return
        }
        currentModel.currentDateTime = yesterday
    }
    
    
}
