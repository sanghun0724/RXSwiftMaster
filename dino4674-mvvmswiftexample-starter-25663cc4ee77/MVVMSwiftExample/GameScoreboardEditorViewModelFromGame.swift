//
//  GameScoreboardEditorViewModelFromGame.swift
//  MVVMSwiftExample
//
//  Created by sangheon on 2021/07/22.
//  Copyright © 2021 Toptal. All rights reserved.
//

import Foundation
//틀을 활용하여 ㄹㅇ 메소드랑 데이터 어떻게 할건지 세부조정 다만들어주고 뷰에서는 보여주기만 할수있게 
class GameScoreboardEditorViewModelFromGame:NSObject,GameScoreboardEditorViewModel {
    
    let game:Game
    
    struct Formatter {
        static let durationFormatter:DateComponentsFormatter = {
            let dateForMatter = DateComponentsFormatter()
            dateForMatter.unitsStyle = .positional
            return dateForMatter
        }()
    }
    
    
    
    //MARK: gameViewModal Protocol
    var homeTeam: String = ""
    var awayTeam: String = ""
    let time: Dynamic<String>
    let score: Dynamic<String>
    let isFinished: Dynamic<Bool>
    let isPasused: Dynamic<Bool>
    
    func toggolePause() {
        if isPasused.value {
            startTimer()
        } else {
            pauseTimer()
        }
        
        self.isPasused.value = !isPasused.value
    }
    
        let homePlayers: [PlayerScoreboardMoveEditorViewModel]
        let awayPlayers: [PlayerScoreboardMoveEditorViewModel]
    
    
    //MARK: init
    init(withGame game: Game) {
        
        
        
        self.homePlayers = GameScoreboardEditorViewModelFromGame.playerViewModel(from: game.homeTeam.players, game: game)
        self.awayPlayers = GameScoreboardEditorViewModelFromGame.playerViewModel(from: game.awayTeam.players, game: game)
        
        
        self.game = game
        
        self.homeTeam = game.homeTeam.name
        self.awayTeam = game.awayTeam.name
        
        self.time = Dynamic(GameScoreboardEditorViewModelFromGame.timeRemaningPretty(for: game))
        self.score = Dynamic(GameScoreboardEditorViewModelFromGame.scorePretty(for: game))
        self.isFinished = Dynamic(game.isFinished)
        self.isPasused = Dynamic(true)
        
        super.init() //https://hcn1519.github.io/articles/2019-02/swift-init-class-deep
        subscribeToNotifications()
        
        
    }
    
    //MARK: Notification(private)
    
    fileprivate func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(gameScoreDiChangeNotification(_:)), name: NSNotification.Name(rawValue: GameNotifications.GameScoreDidChangeNotification), object: game)
    }
    
    fileprivate func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func gameScoreDiChangeNotification(_ notification:NSNotification) {
        self.score.value = GameScoreboardEditorViewModelFromGame.scorePretty(for: game)
        
        if game.isFinished {
            self.isFinished.value = true
        }
    }
    
    //MARK: Private
    
    fileprivate static func playerViewModel(from players:[Player],game: Game) -> [PlayerScoreboardMoveEditorViewModel] {
        var playerViewModels:[PlayerScoreboardMoveEditorViewModel] = [PlayerScoreboardMoveEditorViewModel]()
        for player in players {
            playerViewModels.append(PlayerScoreboardMoveEditorViewModelFromPlayer(withGame: game, player: player))
        }
        return playerViewModels
    }
    
    fileprivate var gameTimer: Timer?
    fileprivate func startTimer() {
        let interval:TimeInterval = 0.001 //이 기준으로 시간 0~ 15분까지 상승
        gameTimer = Timer.schedule(repeatInterval: interval, handler: { (timer) in
            self.game.time += interval
            self.time.value = GameScoreboardEditorViewModelFromGame.timeRemaningPretty(for: self.game)
        })
    }
    
    fileprivate func pauseTimer() {
        gameTimer?.invalidate() //멈추고
        gameTimer = nil //비워주기
    }
    
    //MARK: String Utils
    fileprivate static func timeFormatted(totalMillis: Int) -> String {
        let millis:Int = totalMillis % 1000 / 100 // we want only 1 digit
        let totalSeconds:Int = totalMillis / 1000
        
        let seconds:Int = totalSeconds % 60
        let minutes:Int = (totalSeconds / 60)
        
        return String(format: "%02d:%02d.%d", minutes,seconds,millis)
    }
    
    //fileprivate static 왜쓰는지는 내 정리 참고
    fileprivate static func timeRemaningPretty(for game:Game) -> String {
        return timeFormatted(totalMillis: Int(game.time * 1000))
    }
    
    fileprivate static func scorePretty(for game: Game) -> String {
        return String(format:"\(game.homeTeamScore) - \(game.awayTeamScore)")
    }
    
}
