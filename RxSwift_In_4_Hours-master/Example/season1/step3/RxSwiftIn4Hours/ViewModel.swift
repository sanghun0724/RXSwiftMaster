//
//  ViewModel.swift
//  RxSwiftIn4Hours
//
//  Created by sangheon on 2021/11/28.
//  Copyright © 2021 n.code. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewModel {
    
    let emailText = BehaviorSubject(value: "")
    let pwText = BehaviorSubject(value: "")
    
    let isEmailValid = BehaviorSubject(value: false)
    let isPasswordValid = BehaviorSubject(value: false)
    
    init() {
        _ = emailText.distinctUntilChanged()
            .map(checkEmailValid)
            .bind(to: isEmailValid) //subject를 활용하여 emailText가 바뀔때만 값 전달
        
        _ = pwText.distinctUntilChanged()
            .map(checkPasswordValid)
            .bind(to: isPasswordValid)
            
    }
    
    
//    func setEmailText(_ email:String) {
//        let isValid = checkEmailValid(email)
//        isEmailValid.onNext(isValid)
//    }
//
//    func setPasswordText(_ pw:String) {
//        let isValid = checkPasswordValid(pw)
//        isPasswordValid.onNext(isValid)
//    }
//
//
    
    
    
    // MARK: - Logic

     func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }

     func checkPasswordValid(_ password: String) -> Bool {
        return password.count > 5
    }
}
