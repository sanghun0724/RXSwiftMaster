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
        let stockDetatilControllerFactory:(Stock) -> StockDetailController
    }
    
    var navigationController: UINavigationController?
    let stockDetailControllerFactory:(Stock) -> StockDetailController
    
    let rootViewController:StockListController
    
    required init(dependency: Dependency, payload: ()) {
        rootViewController = dependency.stockListControllerFactory()
        stockDetailControllerFactory = dependency.stockDetatilControllerFactory
    }
    
    func start() {
        rootViewController.coordinator = self // maincoordinator 넣어주기 
        navigationController?.setViewControllers([rootViewController], animated: false)
    }
    
    func stockCellTapped(item:Stock) {
        let vc = stockDetailControllerFactory(item)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
