//
//  ObserverType.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

protocol ObserverType {
    //observer가 볼수 있는 시퀀스의 요소 타입
    associatedtype E
    
    // 시퀀스 이벤트에 대해 옵저버에게 알림
    // - paramater event : 발생된 이벤트 
    func on(_ event: Event<E>)
}
