//
//  Coordinator.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/22.
//

import UIKit



class Coordinator {
    func start(window:UIWindow,rootViewController:UIViewController) {
        let rootViewController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
