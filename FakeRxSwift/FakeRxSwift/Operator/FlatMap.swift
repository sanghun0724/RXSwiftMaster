//
//  FlatMAp.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

extension ObservableType {
    func flatMap<U>(_ transform: @escaping (E) -> Observable<U>) -> Observable<U> {
        return Observable<U> { observer in
            let composite = CompositeDisposable()
            let subscription = self.subscribe(observer: Observer { event in
                switch event {
                case let .next(element):
                    let transformed = transform(element)
                    let disposable = transformed.subscribe(observer: Observer { event in
                        switch event {
                        case .next(let e):
                            observer.on(.next(e))
                        case .error(let err):
                            observer.on(.error(err))
                        case .completed:
                            observer.on(.completed)
                        }
                    })
                    composite.add(disposable: disposable)
                case let .error(error):
                    observer.on(.error(error))
                case .completed:
                    observer.on(.completed)
                }
            })
            composite.add(disposable: subscription)
            return composite
        }
    }
}
