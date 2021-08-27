//
//  Game.swift
//  MVVMExample
//
//  Created by Dino Bartosak on 15/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

enum PlayerInGameMove {
    case onePoint
    case twoPoints
    case assist
    case rebound
    case foul
}

enum GameNotifications {
    static let GameScoreDidChangeNotification = "GameScoreDidChangeNotification"
}
//NSObject 상속받는이유 ? -> Object -c 와의 호환성을 위해. 상속받음으로써 이클래스는 이제 옵젝씨 호출가능 
class Game: NSObject {
    
    let matchWinningScore: UInt = 15
    
    var identifier: String
    var homeTeam: Team
    var awayTeam: Team
    var homeTeamScore: UInt = 0
    var awayTeamScore: UInt = 0
    
    var time: TimeInterval = 0.0
    var isFinished: Bool = false
    
    fileprivate var moveHistory: [(move: PlayerInGameMove, player: Player)]
    
    init(homeTeam: Team, awayTeam: Team, identifier: String) {
        self.identifier = identifier
        
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        
        self.moveHistory = []
    }

    func addPlayerMove(_ move: PlayerInGameMove, for player: Player) {
        if !containsPlayer(player) {
            print("Player not part of this game")
            return
        }
        
        updateMoveHistory(with: move, player: player)
        
        switch move {
        case .onePoint: updateScore(1, withScoringPlayer: player)
        case .twoPoints: updateScore(2, withScoringPlayer: player)
        case .assist: return
        case .rebound: return
        case .foul: return
        }
    }

    func playerMoveCount(for player: Player, move: PlayerInGameMove) -> UInt {
        var moveCount: UInt = 0
        for currentMove in moveHistory {
            if currentMove.move == move && currentMove.player.identifier == player.identifier {
                moveCount += 1
            }
        }
        
        return moveCount
    }
    
    static func isScoringMove(_ move: PlayerInGameMove) -> Bool {
        return move == .onePoint || move == .twoPoints
    }
    
    // MARK: Private
    
    fileprivate func containsPlayer(_ player: Player) -> Bool {
        var contains = false
        
        contains = homeTeam.containsPlayer(player)
        if !contains {
            contains = awayTeam.containsPlayer(player)
        }
        
        return contains
    }
    
    fileprivate func updateMoveHistory(with move: PlayerInGameMove, player: Player) {
        moveHistory.append((move: move, player: player))
    }
    
    fileprivate func updateScore(_ score: UInt, withScoringPlayer player: Player) {
        if isFinished || score == 0 {
            return
        }
        
        if homeTeam.containsPlayer(player) {
            homeTeamScore += score
        } else {
            assert(awayTeam.containsPlayer(player))
            awayTeamScore += score
        }
        
        if checkIfFinished() {
            isFinished = true
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: GameNotifications.GameScoreDidChangeNotification), object: self) //여기선 noti로 UI업데이트
    }
    
    fileprivate func checkIfFinished() -> Bool {
        var isFinished = false
        
        let winningScoreReached = homeTeamScore >= matchWinningScore ||
            awayTeamScore >= matchWinningScore
        
        if winningScoreReached {
            isFinished = abs((Int(awayTeamScore)) - Int(homeTeamScore)) > 1
        }
        
        return isFinished
    }
    
}
