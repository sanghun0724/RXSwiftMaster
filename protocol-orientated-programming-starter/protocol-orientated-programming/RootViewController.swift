//
//  RootViewController.swift
//  protocol-orientated-programming
//
//  Created by sangheon on 2022/01/06.
//

import UIKit

protocol RootViewModelOutput:AnyObject {
    func showLogin()
    func showMainApp(userService:UserService)
}

class RootViewModel {
    
    private let loginStorageService: LoginStorageService
    private let userService:UserService
    
    weak var output:RootViewModelOutput?
    
    init(loginStorageService:LoginStorageService,userService:UserService) {
        self.loginStorageService = loginStorageService
        self.userService = userService
    }
    
    
    func startFlow() {
        if let accessToken = loginStorageService.getUserAccessToken(), !accessToken.isEmpty {
            //user has already logged in previous -> Show Main App
            output?.showMainApp(userService: userService)
        } else  {
            // user has not logged in -> show loggin  screen
            output?.showLogin()
        }
    }
    
}

class RootViewController:UIViewController ,RootViewModelOutput {
    
    private let viewModel:RootViewModel
    
    init(viewModel:RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let customView:UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        customView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.output = self
        viewModel.startFlow()
       
    }
    
    //MARK: - RootViewModel
    func showMainApp(userService:UserService) {
        let viewModel = UserViewModel(userService: userService)
        let userViewController = UserViewController(viewModel: viewModel)
        self.navigationController?.present(userViewController, animated: true, completion: nil)
    }
    
    func showLogin() {
        let loginViewController = LoginViewController()
        self.navigationController?.present(loginViewController, animated: true, completion: nil)
    }
}

protocol LoginStorageService {
    var accessTokenKey:String { get }
    func setUserAccessToken(value:String)
    func getUserAccessToken() -> String?
}

class StroageManage: LoginStorageService {
    
    private let storage = UserDefaults.standard
    
    var accessTokenKey:String {
        return "ACCESS_TOKEN"
    }
    
    func setUserAccessToken(value: String) {
        storage.set(value, forKey: accessTokenKey)
    }
    
    func getUserAccessToken() -> String? {
        return storage.string(forKey: accessTokenKey)
    }
}
