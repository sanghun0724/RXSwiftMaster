//
//  LoginViewModel.swift
//  loginValidation
//
//  Created by sangheon on 2022/01/02.
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {
    //MARK: Properties
    let idPublishSubject = PublishSubject<String>()
    let pwPublishSubject = PublishSubject<String>()
    
    
    //MARK: Helpers
    func isValid() -> Observable<Bool> {
       return Observable.combineLatest(idPublishSubject.asObservable(), pwPublishSubject.asObservable()).map { id, pw in
            return  id.count > 3 && pw.count > 3
        }
    }
}
