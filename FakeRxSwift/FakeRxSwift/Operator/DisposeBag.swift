//
//  DisposeBag.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

final class DisposeBag: Disposable {
    
    private var disposables = [Disposable]()
    
    func add (disposable: Disposable) {
        disposables.append(disposable)
    }
    
    func dispose() {
        disposables.forEach { $0.dispose() }
        disposables.removeAll()
    }
    
    static func += (left: DisposeBag, right: Disposable) {
        left.add(disposable: right)
    }
    
    deinit {
        dispose()
    }
}

extension Disposable {
    func dispose(by bag: DisposeBag) {
        bag += self
    }
}
