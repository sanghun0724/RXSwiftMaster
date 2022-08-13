//
//  AnonymousDisposable.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/09.
//

import Foundation

final class AnonymousDisposable: Disposable {
    private let disposedAction: () -> Void
    
    init(_ disposedAction: @escaping () -> Void) {
        self.disposedAction = disposedAction
    }
    
    func dispose() {
        disposedAction()
    }
    
}




