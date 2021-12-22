//
//  CompositonRoot.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/22.
//

import Foundation

struct AppDependency {
    let mainCoordinator:MainCoordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let mainCoordinator:MainCoordinator = .init()
        
        return .init(mainCoordinator: mainCoordinator)
    }
}
//H4ZRG44U4X1T6VSV
