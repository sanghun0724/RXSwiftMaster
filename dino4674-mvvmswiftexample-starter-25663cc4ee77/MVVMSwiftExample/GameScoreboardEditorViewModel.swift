//
//  GameScoreboardEditorViewModel.swift
//  MVVMSwiftExample
//
//  Created by sangheon on 2021/07/22.
//  Copyright © 2021 Toptal. All rights reserved.
//

import Foundation


protocol GameScoreboardEditorViewModel { //해당 데이터 형태를 가진 틀틀틀  //view에 맞춘 데이터 틀 
    
    var homePlayers: [PlayerScoreboardMoveEditorViewModel] { get }
    var awayPlayers: [PlayerScoreboardMoveEditorViewModel] { get }
    
    var homeTeam:String { get }
    var awayTeam:String { get }
    var time:Dynamic<String> { get }
    var score:Dynamic<String>{ get }
    var isFinished:Dynamic<Bool> { get }
    
    var isPasused:Dynamic<Bool> { get }
    func toggolePause()
}
