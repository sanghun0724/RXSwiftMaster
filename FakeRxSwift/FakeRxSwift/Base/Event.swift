//
//  Event.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/09.
//

import Foundation

enum Event<T> {
    case next(T)
    case error(Swift.Error)
    case completed
}
