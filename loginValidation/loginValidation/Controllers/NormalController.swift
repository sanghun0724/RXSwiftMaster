//
//  normalController.swift
//  loginValidation
//
//  Created by sangheon on 2022/01/04.
//

import UIKit

class NormalController:UIViewController,TestDelegate {
    
    
     var loginController = LoginViewController()
    
    //MARK:Properties
    private let label:UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let buttton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(moveAway), for: .touchUpInside)
        return button
    }()
    
    @objc func moveAway() {
        
        if let navigationController = self.navigationController {
          navigationController.pushViewController(LoginViewController(), animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginController.delegate2 = self
        view.backgroundColor = .red
        configureUI()
    }
    
    func fetchData(_ str: String) {
        print("test")
        label.text = str
    }
    
    //MARK:Configure
    func configureUI() {
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(buttton)
        buttton.translatesAutoresizingMaskIntoConstraints = false
        buttton.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 100).isActive = true
        buttton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}
