//
//  Observable.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

final class Observable<Element>: ObservableType {
    
    typealias E = Element
    
    private let subscribeHandler: (Observer<Element>) -> Disposable
    
    init(observer subscribeHandler: @escaping (Observer<Element>) -> Disposable) {
        self.subscribeHandler = subscribeHandler
    }
    
    func subscribe<O: ObserverType>(observer: O) -> Disposable where O.E == E {
        let compositeDisposable = CompositeDisposable()
        
        let subscribtion = subscribeHandler(Observer { event in
            observer.on(event)
            switch event {
            case .error, .completed:
                compositeDisposable.dispose()
            default: break
            }
        })
        
        compositeDisposable.add(disposable: subscribtion)
        return compositeDisposable
    }
    
}
