//
//  BaseViewModel.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/28.
//

import Foundation
import Combine

class BaseViewModel {
    var subscriber:Set<AnyCancellable> = .init()
    
    init() {
        subscriber = .init()
    }
}
