//
//  AppCoordinator.swift
//  EventsApp
//
//  Created by sangheon on 2022/02/02.
//

import UIKit


protocol Coordinator:AnyObject {
    var childCoordinators: [Coordinator] { get }
    func start()
    
}

final class AppCoordinator:Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let window:UIWindow
    
    init(window:UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let eventListCoordinator = EventListCoordinator(navigationController: navigationController)
        eventListCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    
}
