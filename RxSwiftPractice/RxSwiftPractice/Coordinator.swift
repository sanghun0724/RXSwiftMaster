//
//  Coordinator.swift
//  RxSwiftPractice
//
//  Created by sangheon on 2021/12/19.
//

import UIKit

class Coordinator {
    let window:UIWindow
    
    init(window:UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootViewController = RootViewController()
        let navigationRootViewController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationRootViewController
        window.makeKeyAndVisible()
    }
}
