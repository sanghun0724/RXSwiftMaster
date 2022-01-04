//
//  normalController.swift
//  loginValidation
//
//  Created by sangheon on 2022/01/04.
//

import UIKit

class NormalController:UIViewController,TestDelegate {
    
    
   // weak var loginController = LoginViewController()
    
    //MARK:Properties
    private let label:UILabel = {
        let label = UILabel()
        label.text = "before"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        print("hi")
        configureUI()
       // loginController!.delegate2 = self
    }
    
    
    func fetchData(_ str: String) {
        self.label.text = str
    }
    
    //MARK:Configure
    func configureUI() {
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}
