//
//  CompositeDisposable.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

final class CompositeDisposable: Disposable {
    private var isDisposed: Bool = false
    private var disposables: [Disposable] = []
    
    //dispose가 된 상태라면 disposable를 dispose 시키고 . 그렇지 않으면 Disposable를 추가 .
    func add(disposable: Disposable) {
        guard !isDisposed else {
            disposable.dispose()
            return
        }
        disposables.append(disposable)
    }
    
    func dispose() {
        guard !isDisposed else { return }
        isDisposed = true
        disposables.forEach{ $0.dispose() }
    }
    
    
}
