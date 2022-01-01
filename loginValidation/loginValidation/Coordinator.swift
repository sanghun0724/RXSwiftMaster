//
//  Coordinator.swift
//  loginValidation
//
//  Created by sangheon on 2022/01/01.
//

import UIKit

class Coordinator {
    let window:UIWindow
    
    init(window:UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = LoginViewController()
        window.makeKeyAndVisible()
    }
    
}
