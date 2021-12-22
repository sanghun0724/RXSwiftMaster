//
//  CompositonRoot.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/22.
//

import Foundation

struct AppDependency {
    let coordinator:Coordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let coordinator:Coordinator = .init()
        
        return .init(coordinator: coordinator)
    }
}
