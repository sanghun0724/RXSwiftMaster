//
//  RootViewController.swift
//  protocol-orientated-programming
//
//  Created by sangheon on 2022/01/06.
//

import UIKit

class RootViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
    func processFlow() {
        if let accessToken = UserDefaults.standard.string(forKey: "ACCESS_TOKEN") , !accessToken.isEmpty {
            // User has logged in previously
            showMainApp()
        } else {
            // User has not logged in
            showLogin()
        }
    }
    
    func showMainApp(userSerivce:UserService) {
        let viewModel = UserViewModel(userService: userSerivce)
        let userViewController = UserViewController(viewModel: viewModel)
    }
    
    func showLogin() {
        let loginViewController = LoginViewController()
        self.navigationController?.present(loginViewController, animated: true, completion: nil)
    }
}
