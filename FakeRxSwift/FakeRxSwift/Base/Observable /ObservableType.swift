//
//  ObservableType.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

protocol ObservableType {
    associatedtype E
    
    // observable을 구독하여 observer에 Event를 전달. Observer의 E와 E를 비교하여 타입 제약함.
    // -Parameter observer: Event를 전달받을 Observer
    func subscribe<O: ObserverType>(observer: O) -> Disposable where O.E == E
}
