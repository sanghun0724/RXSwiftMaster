//
//  ViewController.swift
//  RxSwiftIn4Hours
//
//  Created by iamchiwon on 21/12/2018.
//  Copyright © 2018 n.code. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {
    var disposeBag = DisposeBag()
    //시간에 따라 변하는 값
    let idInputText : BehaviorSubject<String> = BehaviorSubject(value: "")
    let idValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let pwInputText : BehaviorSubject<String> = BehaviorSubject(value: "")
    let pwValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    let whatIsRelay = BehaviorRelay<Bool>(value: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput()
        bindOutput()
        
        self.whatIsRelay.accept(true) // error x completed x only next 죽지않는놈(스트림종료x)
        //UI는 에러나도 없어지면 안됨 , UI연결용
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disposeBag = DisposeBag()
        //view가 없어질때 dispose를초기화 해줘서  weak self를 안써도 초기화로 memory leak을 막음 
    }

    // MARK: - IBOutler

    @IBOutlet var idField: UITextField!
    @IBOutlet var pwField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var idValidView: UIView!
    @IBOutlet var pwValidView: UIView!

    // MARK: - Bind UI
    //driver, Relay는 UI를 위한거 코코아에만 들어있음
    private func bindInput() {
        //input : 아이디입력, 비번입력
        idField.rx.text.orEmpty
            .bind(to: idInputText) //결과 값 idInputtext에 저장
            .disposed(by: disposeBag)
        
        idInputText
            .map(checkEmailValid)
            .bind(to: idValid)
            .disposed(by: disposeBag)
        
        pwField.rx.text.orEmpty
            .bind(to: pwInputText)
            .disposed(by: disposeBag)
        
        pwInputText
            .map(checkPasswordValid)
            .bind(to: pwValid) //결과값 pwValid에 저장
            .disposed(by: disposeBag)
    
//        idField.rx.text.orEmpty
//            .map(checkEmailValid)
//            .subscribe(onNext: { s in
//                self.idValidView.isHidden = s
//        })
//        .disposed(by:disposeBag)
//
//        pwField.rx.text.orEmpty
//            .map(checkPasswordValid)
//            .subscribe(onNext: { p in
//                self.pwValidView.isHidden = p
//            })
//            .disposed(by: disposeBag)
//
//        Observable.combineLatest(idField.rx.text.orEmpty.map(checkEmailValid), pwField.rx.text.orEmpty.map(checkPasswordValid)) { s1 , s2  in  s1 && s2 }
//            .subscribe(onNext: { b in
//                self.loginButton.isEnabled = b
//            })
//            .disposed(by: disposeBag)
    }
    
    private func bindOutput() {
        //output: 불릿,로그인버튼Enable
        idValid.subscribe(onNext: { b in self.idValidView.isHidden = b})
            .disposed(by: disposeBag)

        pwValid.subscribe(onNext: { b in self.pwValidView.isHidden = b})
            .disposed(by: disposeBag)
        
        Observable.combineLatest(idValid, pwValid,resultSelector: { $0 && $1 })
            .subscribe(onNext: {s in self.loginButton.isEnabled = s})
            .disposed(by: disposeBag)
    }
    

    // MARK: - Logic

    private func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }

    private func checkPasswordValid(_ password: String) -> Bool {
        return password.count > 5
    }
}
