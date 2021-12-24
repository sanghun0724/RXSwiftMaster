//
//  MainCoordinator.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/23.
//

import UIKit
import Pure

class MainCoordinator:Coordinator , FactoryModule {
    
    struct Dependency {
        let stockListControllerFactory:() -> StockListController
    }
    
    var navigationController: UINavigationController?
    
    let rootViewController:StockListController
    
    required init(dependency: Dependency, payload: ()) {
        rootViewController = dependency.stockListControllerFactory()
    }
    
    func start() {
        navigationController?.setViewControllers([rootViewController], animated: false)
    }
}
