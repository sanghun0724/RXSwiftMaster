//
//  PlayerScoreboardMoveEditorViewModel.swift
//  MVVMSwiftExample
//
//  Created by sangheon on 2021/07/22.
//  Copyright © 2021 Toptal. All rights reserved.
//

import Foundation

protocol PlayerScoreboardMoveEditorViewModel {
    var playerName:String { get }
    
    var onePointMoveCount:Dynamic<String> { get } //변경될 값이기 때문에 바인딩 가즈아
    var twoPointMoveCount:Dynamic<String> { get }
    var assistMoveCount:Dynamic<String> { get }
    var reboundMoveCount:Dynamic<String> { get }
    var foulMoveCount:Dynamic<String> { get }
    
    func onePointMove()
    func twoPointsMove()
    func assistMove()
    func reboundMove()
    func foulMove()
}
//Dynamic타입은 특정 프로퍼티의 값을 변경할 수 있고, 동시에 변경 리스너 객체에 알리며 이경우에는 view가 됨 
