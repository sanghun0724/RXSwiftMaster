//
//  Subscribe.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

extension ObservableType {
    func subscribe(onNext: ((E) -> Void)? = nil,
                   onError: ((Swift.Error) -> Void)? = nil,
                   onCompleted: (() -> Void)? = nil) -> Disposable {
        return subscribe(observer: Observer { event in
            switch event {
            case let .next(element): onNext?(element)
            case let .error(e): onError?(e)
            case .completed: onCompleted?()
            }
        })
    }
}
