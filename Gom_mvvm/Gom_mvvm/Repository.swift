//
//  Repository.swift
//  Gom_mvvm
//
//  Created by sangheon on 2021/11/02.
//

import Foundation

class Repository {
    func fetchNow(onCompleted: @escaping (Date) -> Void) {
        let url = ""
        
        URLSession.shared.dataTask(with: URL(string: url)!) { [weak self] data, _,_ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: data) else { return }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
            
            guard let now  = formatter.date(from: model.currentDateTime) else {
                
            }
            
            
        }
    }
}
