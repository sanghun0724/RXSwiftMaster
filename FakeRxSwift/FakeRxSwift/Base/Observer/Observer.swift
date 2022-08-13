//
//  Observer.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

final class Observer<E>: ObserverType {
    private let handler: (Event<E>) -> Void
    
    init(handler: @escaping (Event<E>) -> Void) {
        self.handler = handler
    }
    
    func on(_ event: Event<E>) {
        handler(event)
    }
}
