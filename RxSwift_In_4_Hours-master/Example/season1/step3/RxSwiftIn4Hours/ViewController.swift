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
    let sss  = PublishSubject<Int>() //애도 Observable의 한 종류임 but 차이점은 multicast , 종류는 4가지
     //애도 컴플릿이나 에러나면 종료  -> UI에서 쓸거면 Relay로 (subject ui판이라 생각하면됨)
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        
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
    private func bindUI() {
        //Input : 이메일,비번입력
        idField.rx.text.orEmpty
            .bind(to: viewModel.emailText)
            .disposed(by: disposeBag)
            
        
        pwField.rx.text.orEmpty
            .bind(to: viewModel.pwText)
            .disposed(by: disposeBag)
        
        //output :이메일 , 비번 체크 결과
        viewModel.isEmailValid
            .bind(to: idValidView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.isPasswordValid
            .bind(to: pwValidView.rx.isHidden)
            .disposed(by: disposeBag)
        
        //output : button Enable
        Observable.combineLatest(viewModel.isEmailValid, viewModel.isPasswordValid) {$0 && $1 }
            .bind(to: self.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    

}
