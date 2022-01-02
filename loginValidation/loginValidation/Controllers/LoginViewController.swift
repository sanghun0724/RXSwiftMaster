//
//  LoginViewController.swift
//  loginValidation
//
//  Created by sangheon on 2022/01/01.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialButtons
import RxSwift
import RxCocoa

class LoginViewController:UIViewController {
    
    //MARK: Properties
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
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
        configureKeyboard()
        loginBind()
    }
    
    // MARK: Configures
    
    func configureKeyboard() {
        dismissKeyboardWhenTappedAround()
        moveViewWhenKeyboardAppearedOrDisappeared()
    }
    
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
    }
    
    //MARK: Binds
    func loginBind() {
        self.idTextField.rx.text.map { $0 ?? "" } //한글자씩 칠때마다
            .bind(to: viewModel.idPublishSubject)
            .disposed(by: disposeBag)
        
        self.pwTextField.rx.text.map { $0 ?? "" }
            .bind(to: viewModel.pwPublishSubject)
            .disposed(by: disposeBag)
        
        viewModel.isValid().subscribe(onNext: { valid in
            self.loginButton.isUserInteractionEnabled = valid
            if valid {
                self.loginButton.alpha = 1
            } else {
                self.loginButton.alpha = 0.3
            }
        }).disposed(by: disposeBag)
    }
    
}


























