//
//  LoginViewController.swift
//  loginValidation
//
//  Created by sangheon on 2022/01/01.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialButtons

class LoginViewController:UIViewController {
    
    //MARK: Properties
    private lazy var idTextField:MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "id"
        tf.placeholder = "enter your id"
        tf.leadingAssistiveLabel.text = "This is where enter your id"
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tf.sizeToFit()
        return tf
    }()
    
    private lazy var pwTextField:MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "pw"
        tf.placeholder = "enter your pw"
        tf.leadingAssistiveLabel.text = "This is where enter your pw"
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tf.sizeToFit()
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var loginButton:MDCButton = {
        let bt = MDCButton()
        bt.setTitle("login", for: UIControl.State.normal)
        bt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bt.setBackgroundColor(UIColor.purple)
        bt.isUserInteractionEnabled = false
        bt.alpha = 0.3
        return bt
    }()
    
    private lazy var stack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [idTextField,pwTextField,loginButton])
        stack.axis = .vertical
        stack.spacing = 50
        return stack
    }()
    
    
    //MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
    }
    
}


























