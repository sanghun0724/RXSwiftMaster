//
//  Repository.swift
//  Gom_mvvm
//
//  Created by sangheon on 2021/11/02.
//

import Foundation

class Repository {
    func fetchNow(onCompleted: @escaping (UtcTimeModel) -> Void) {
        let url = ""
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, _,_ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: data) else { return }
            onCompleted(model)
        }.resume()
    }
}


