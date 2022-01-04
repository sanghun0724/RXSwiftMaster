//
//  SceneDelegate.swift
//  loginValidation
//
//  Created by sangheon on 2022/01/01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
//        let coordinator = Coordinator(window: window!)
//        coordinator.start()
        let navi = UINavigationController(rootViewController: LoginViewController())
        window!.rootViewController = navi
        window!.makeKeyAndVisible()
    }
}

