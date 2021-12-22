//
//  MainCoordinator.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/23.
//

import UIKit

class MainCoordinator:Coordinator {
    var navigationController: UINavigationController?
    
    func start() {
        let rootViewController = StockListController()
        navigationController?.setViewControllers([rootViewController], animated: false)
    }
}
