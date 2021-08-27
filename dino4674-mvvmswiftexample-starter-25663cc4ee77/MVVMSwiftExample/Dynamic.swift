//
//  Dynamic.swift
//  MVVMSwiftExample
//
//  Created by sangheon on 2021/07/28.
//  Copyright © 2021 Toptal. All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener:Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener:Listener?) {
        self.listener = listener
        listener?(value) //이 클래스의 있는 클로져 변수
    }
    
    var value:T {
        didSet {
            listener?(value) //이 클래스의 있는 클로져 변수
        }
    }
    
    init(_ v:T) {
        value = v
    }
}
//View 생명주기 동안 변경하려는 ViewModel의 프로퍼티에 이 클래스를 사용할 것임 ㅇㅅㅇ
