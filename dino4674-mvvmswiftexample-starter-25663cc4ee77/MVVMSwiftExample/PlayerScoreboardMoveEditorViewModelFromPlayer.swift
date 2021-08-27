//
//  PlayerScoreboardMoveEditorViewModelFromPlayer.swift
//  MVVMSwiftExample
//
//  Created by sangheon on 2021/07/23.
//  Copyright © 2021 Toptal. All rights reserved.
//

import Foundation

class PlayerScoreboardMoveEditorViewModelFromPlayer: PlayerScoreboardMoveEditorViewModel {
    
    fileprivate let player:Player
    fileprivate let game:Game
    
    //MARK: Protocol
    
    var playerName: String = ""
    let onePointMoveCount: Dynamic<String> //실제 프로터피 변경 x
    let twoPointMoveCount: Dynamic<String> //Dynamic 객체의 value 프로퍼티 변경
    let assistMoveCount: Dynamic<String> // so.. let 프로퍼티 적용
    let reboundMoveCount: Dynamic<String>
    let foulMoveCount: Dynamic<String>
    func onePointMove() {
        makeMove(.onePoint)
    }
    
    func twoPointsMove() {
        makeMove(.twoPoints)
    }
    
    func assistMove() {
        makeMove(.assist)
    }
    
    func reboundMove() {
        makeMove(.rebound)
    }
    
    func foulMove() {
        makeMove(.foul)
    }
    
    //MARK: init
    init(withGame game:Game,player: Player) {
        self.game = game
        self.player = player
        
        self.playerName = player.name
        self.onePointMoveCount = Dynamic("\(game.playerMoveCount(for: player ,move: .onePoint))")
        self.twoPointMoveCount = Dynamic("\(game.playerMoveCount(for: player ,move: .twoPoints))")
        self.assistMoveCount = Dynamic("\(game.playerMoveCount(for: player ,move: .assist))")
        self.reboundMoveCount = Dynamic("\(game.playerMoveCount(for: player ,move: .rebound))")
        self.foulMoveCount = Dynamic("\(game.playerMoveCount(for: player ,move: .foul))")
    } //Dynamic의 value 값들 초기화
    
    
    //MARK: Private
    fileprivate func makeMove(_ move:PlayerInGameMove) {
        game.addPlayerMove(move, for: player)
        
        onePointMoveCount.value = "\(game.playerMoveCount(for: player ,move: .onePoint))"
        twoPointMoveCount.value = "\(game.playerMoveCount(for: player ,move: .twoPoints))"
        assistMoveCount.value = "\(game.playerMoveCount(for: player ,move: .assist))"
        reboundMoveCount.value = "\(game.playerMoveCount(for: player ,move: .rebound))"
        foulMoveCount.value = "\(game.playerMoveCount(for: player ,move: .foul))"
    }
}
