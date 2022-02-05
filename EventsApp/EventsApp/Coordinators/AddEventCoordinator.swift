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
    
    var parentCoordinator:EventListCoordinator?
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let modalNavigationController = UINavigationController()
        let addEventViewController = AddEventViewController()
        modalNavigationController.setViewControllers([addEventViewController], animated: false)
        let addEventViewModel = AddEventViewModel()
        addEventViewModel.coordinator = self 
        addEventViewController.viewModel = addEventViewModel
        navigationController.present(modalNavigationController,animated: true)
        
        //create add evet view Controller
        //create add event view Model
        //present modally controller using navigation controller
    }
    
    func didFinishAddEvent() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("deinit from add event Coordinator")
    }
    
}
