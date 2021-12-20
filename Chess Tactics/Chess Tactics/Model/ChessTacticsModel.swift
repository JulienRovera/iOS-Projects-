//
//  ChessTacticsModel.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/16/21.
//

import Foundation

struct ChessTacticsModel{
    let manager: StorageManager
    var intermediatePuzzleList : [Puzzle]
    var userCreatedPuzzles: [Puzzle]
    var beginnerPuzzleList: [Puzzle]
    var advancedPuzzleList: [Puzzle]
    var recentPuzzlesList: [Puzzle]
    var numBeginnerPuzzlesCompleted: Int
    var numIntermediatePuzzlesCompleted: Int
    var numAdvancedPuzzlesCompleted: Int
    var currentPuzzle: Int
    init(){
        manager = StorageManager()
        beginnerPuzzleList = manager.beginnerPuzzleList
        intermediatePuzzleList = manager.intermediatePuzzleList
        advancedPuzzleList = manager.advancedPuzzleList
        userCreatedPuzzles = manager.userCreatedPuzzleList
        recentPuzzlesList = manager.recentPuzzleList
        currentPuzzle = 1
        numBeginnerPuzzlesCompleted = 0
        numIntermediatePuzzlesCompleted = 0
        numAdvancedPuzzlesCompleted = 0
    }
    
    mutating func insertRecentPuzzle(puzzle: Puzzle){
        recentPuzzlesList.insert(puzzle, at: 0)
        if recentPuzzlesList.count > 15{
            recentPuzzlesList.remove(at: 15)
        }
    }
}
