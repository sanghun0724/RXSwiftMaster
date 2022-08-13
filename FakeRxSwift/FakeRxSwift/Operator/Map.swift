//
//  Map.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

extension ObservableType {
    func map<U>(_ transform: @escaping (E) -> U) -> Observable<U> {
        return Observable<U> { observer in
            return self.subscribe(observer: Observer { event in
                switch event {
                case let .next(element):
                    observer.on(.next(transform(element)))
                case let .error(error):
                    observer.on(.error(error))
                case .completed:
                    observer.on(.completed)
                }
            })
        }
    }
}
