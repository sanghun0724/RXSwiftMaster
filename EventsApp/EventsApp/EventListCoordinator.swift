//
//  EventListCoordinator.swift
//  EventsApp
//
//  Created by sangheon on 2022/02/02.
//

import Foundation
import UIKit

final class EventListCoordinator:Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
   
    private let navigationController:UINavigationController
    
    init(navigationController:UINavigationController) { //Tabbar가능
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListViewController = EventListViewController()
        navigationController.setViewControllers([eventListViewController], animated: false)
        
    }
    
}
