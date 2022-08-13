//
//  MapThrowsError.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

extension ObservableType {
    func mapThrowError<U>(_ transform: @escaping (E) throws -> U) -> Observable<U> {
        return Observable<U> { observer in
            return self.subscribe(observer: Observer { event in
                switch event {
                case let .next(element):
                    do {
                        try observer.on(.next(transform(element)))
                    } catch {
                        observer.on(.error(error))
                    }
                case let .error(error):
                    observer.on(.error(error))
                case .completed:
                    observer.on(.completed)
                }
            })
        }
    }
}
