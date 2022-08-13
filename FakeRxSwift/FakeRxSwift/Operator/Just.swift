//
//  Just.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

extension ObservableType {
    static func just(_ value: E) -> Observable<E> {
        return Observable { (observer) -> Disposable in 
            observer.on(.next(value))
            observer.on(.completed)
            return NonDisposable()
        }
    }
}
