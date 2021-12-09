//
//  ViewModel.swift
//  RxSwift+MVVM
//
//  Created by sangheon on 2021/12/08.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel {
    var sumPrice = 0 {
        didSet {
            sumPrice$.onNext(sumPrice)
        }
    }
    var sumPrice$ = BehaviorSubject(value: 0) //초기값 가진 Subject
    
    func addFried(_ price:Int) {
        sumPrice += price
    }
    
    func subFried(_ price: Int) {
        sumPrice -= price
    }
    
    
}
