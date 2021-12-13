//
//  ViewModel.swift
//  RxSwift+MVVM
//
//  Created by sangheon on 2021/12/08.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class ViewModel {
    
//    var sumPrice = 0 {
//        didSet {
//            sumPrice$.onNext(sumPrice)
//        }
//    }
   
    var sumPrice$ = BehaviorRelay(value: 0) //초기값 가진 Subject
    //Behavior을 사용함으로써 위처럼 변수따로 사용안하고 sumPrice의 value 를 꺼내쓸수 있음
    //Relay -> value좀더 편하게 꺼내쓰는거 가능  (+ Relay는 끝나지 않는놈 no error, no complete)
    
    func addFried(_ price:Int) {
        let newPrice = sumPrice$.value + price
        sumPrice$.accept(newPrice)
    }
    
    func subFried(_ price: Int) {
        let newPrice = sumPrice$.value - price
        sumPrice$.accept(newPrice)
    }
    
    
}
