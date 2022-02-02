//
//  AddEventCoordinator.swift
//  EventsApp
//
//  Created by sangheon on 2022/02/02.
//

import UIKit


final class AddEventCoordinator:Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController:UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .blue
        navigationController.present(viewController,animated: true)
        
        //create add evet view Controller
        //create add event view Model
        //present modally controller using navigation controller
    }
    
}
