//
//  ViewController.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/09.
//

import UIKit

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        Observable.just(1)
            .map{ $0 * 2 }
            .subscribe(onNext: { print($0) })
            .dispose(by: disposeBag)
    }


}

