//
//  ChessTacticsManager.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/9/21.
//

import Foundation
import SwiftUI

enum attempted{
    case correct
    case incorrect
    case unfinished
}
class ChessTacticsManager: ObservableObject{
    @Published var model = ChessTacticsModel()
    @Published var game: Game
    @Published var puzzleAttempts: [attempted]
    @Published var puzzleButtonText: String
    @Published var puzzleButtonDisabled: Bool
    @Published var puzzleButtonSuperDisabled: Bool
    @Published var confirmCancel: Bool
    @Published var disableCreatePuzzlesView: Bool
    var currentPuzzle: Puzzle?
    var currentPuzzleDifficulty: puzzleDifficulty
    var disableBoard: Bool
    var promotingPiece: Bool
    var attemptCounter: Int
    var puzzleFullMovesMade: Int
    var toMove: pieceColor
    var currentFen: String
    init(){
        disableBoard = false
        promotingPiece = false
        puzzleButtonDisabled = false
        puzzleButtonSuperDisabled = false
        confirmCancel = false
        puzzleButtonText = "Retry"
        puzzleAttempts = [.unfinished, .unfinished, .unfinished]
        attemptCounter = 0
        puzzleFullMovesMade = 0
        game = Game(fen: ChessConstants.startingFen, isPuzzle: false)
        toMove = .white
        currentFen = ""
        currentPuzzle = nil
        currentPuzzleDifficulty = .beginner
        disableCreatePuzzlesView = false
    }
    
    func initializeNewGame(fen: String, isPuzzle: Bool){
        game = Game(fen: fen, isPuzzle: isPuzzle)
        disableBoard = false
        disableCreatePuzzlesView = false
        promotingPiece = false
        if isPuzzle{
            if currentPuzzle != nil && currentPuzzleDifficulty != .userCreated && currentPuzzleDifficulty != .recent{
                model.insertRecentPuzzle(puzzle: currentPuzzle!)
            }
            puzzleButtonDisabled = true
            puzzleButtonSuperDisabled = false
            game.checkCastlePossible()
        }
        else{
            puzzleButtonDisabled = false
        }
        puzzleButtonText = "Retry"
        puzzleAttempts = [.unfinished, .unfinished, .unfinished]
        attemptCounter = 0
        puzzleFullMovesMade = 0
        toMove = game.currentTurn
    }
    
    func puzzleButtonPushed(){
        
        switch currentPuzzleDifficulty{
        case .beginner:
            if model.beginnerPuzzleList[model.currentPuzzle].completed{
                getPuzzle(difficulty: currentPuzzleDifficulty, index: nil)
                return
            }
            if model.beginnerPuzzleList[model.currentPuzzle].failed{
                seePuzzleSolution()
                return
            }
            retryPuzzle()
        case .intermidiate:
            if model.intermediatePuzzleList[model.currentPuzzle].completed{
                getPuzzle(difficulty: currentPuzzleDifficulty, index: nil)
                return
            }
            if model.intermediatePuzzleList[model.currentPuzzle].failed{
                seePuzzleSolution()
                return
            }
            retryPuzzle()
        case .advanced:
            if model.advancedPuzzleList[model.currentPuzzle].completed{
                getPuzzle(difficulty: currentPuzzleDifficulty, index: nil)
                return
            }
            if model.advancedPuzzleList[model.currentPuzzle].failed{
                seePuzzleSolution()
                return
            }
            retryPuzzle()
        case .userCreated:
            if model.userCreatedPuzzles[model.currentPuzzle].failed{
                seePuzzleSolution()
                return
            }
            if model.userCreatedPuzzles[model.currentPuzzle].completed{
                //what to do when puzzle completed
            }
            retryPuzzle()
        case .recent:
            if model.recentPuzzlesList[model.currentPuzzle].failed{
                seePuzzleSolution()
                return
            }
            if model.recentPuzzlesList[model.currentPuzzle].completed{
                //what to do when puzzle completed
            }
            retryPuzzle()
        }
    }
    
    func seePuzzleSolution(){
        retryPuzzle()
        attemptCounter -= 1
        /*game.moveList = model.puzzleList[model.currentPuzzle].moveList
        print(game.numHalfMoves)
        print(game.viewedHalfMove)
        game.numHalfMoves = model.puzzleList[model.currentPuzzle].moves.count
        print(game.numHalfMoves)*/
        
        switch currentPuzzleDifficulty {
        case .beginner:
            model.beginnerPuzzleList[model.currentPuzzle].completed = true
            model.numBeginnerPuzzlesCompleted += 1
            currentPuzzle!.completed = true
            model.beginnerPuzzleList[model.currentPuzzle].failed = false
        case .intermidiate:
            model.intermediatePuzzleList[model.currentPuzzle].completed = true
            model.numIntermediatePuzzlesCompleted += 1
            currentPuzzle!.completed = true
            model.intermediatePuzzleList[model.currentPuzzle].failed = false
        case .advanced:
            model.advancedPuzzleList[model.currentPuzzle].completed = true
            model.numAdvancedPuzzlesCompleted += 1
            currentPuzzle!.completed = true
            model.advancedPuzzleList[model.currentPuzzle].failed = false
        case .userCreated:
            model.userCreatedPuzzles[model.currentPuzzle].completed = true
            currentPuzzle!.completed = true
            model.userCreatedPuzzles[model.currentPuzzle].failed = false
        case .recent:
            model.recentPuzzlesList[model.currentPuzzle].completed = true
            currentPuzzle!.completed = true
            model.recentPuzzlesList[model.currentPuzzle].failed = false
        }
        displaySolution()
        if currentPuzzleDifficulty != .userCreated{
            puzzleButtonText = "Next"
            puzzleButtonDisabled = false
            disableBoard = true
            return
        }
        puzzleButtonText = "Solved"
        puzzleButtonDisabled = false
        puzzleButtonSuperDisabled = true
        disableBoard = true
    }
    
    func retryPuzzle(){
        disableBoard = false
        promotingPiece = false
        puzzleButtonDisabled = true
        puzzleButtonText = "Retry"
        attemptCounter += 1
        puzzleFullMovesMade = 0
        switch currentPuzzleDifficulty{
        case .beginner:
            game = Game(fen: model.beginnerPuzzleList[model.currentPuzzle].fen, isPuzzle: true)
            game.checkCastlePossible()
        case.intermidiate:
            game = Game(fen: model.intermediatePuzzleList[model.currentPuzzle].fen, isPuzzle: true)
            game.checkCastlePossible()
        case.advanced:
            game = Game(fen: model.advancedPuzzleList[model.currentPuzzle].fen, isPuzzle: true)
            game.checkCastlePossible()
        case.userCreated:
            game = Game(fen: model.userCreatedPuzzles[model.currentPuzzle].fen, isPuzzle: true)
            game.checkCastlePossible()
        case .recent:
            game = Game(fen: model.recentPuzzlesList[model.currentPuzzle].fen, isPuzzle: true)
            game.checkCastlePossible()
        }
        
        toMove = game.currentTurn
    }
    
    func updateMoveList(){
        game.viewedHalfMove += 1
        var updatedHalfMove = game.viewedHalfMove + 1
        if(game.viewedHalfMove != game.numHalfMoves - 1){
            game.numHalfMoves = updatedHalfMove
            if updatedHalfMove % 2 == 1{
                let newFullMove = FullMove(number: ((updatedHalfMove/2) + 1), firstMove: game.currentHalfMove)
                game.moveList[updatedHalfMove/2] = newFullMove
            }
            else{
                game.moveList[(updatedHalfMove/2) - 1].setSecondMove(as: game.currentHalfMove)
                updatedHalfMove -= 1
            }
            updatedHalfMove += 2
            for index in stride(from: game.moveList.count - 1, through: updatedHalfMove / 2, by: -1){
                game.moveList.remove(at: index)
            }
            return
        }
        
        if game.numHalfMoves % 2 == 1{
            let newFullMove = FullMove(number: ((game.numHalfMoves/2) + 1), firstMove: game.currentHalfMove)
            game.moveList.append(newFullMove)
            if game.isPuzzle && !currentPuzzle!.completed{
            checkIfCorrectMove()
            }
            return
        }
        game.moveList[(game.numHalfMoves/2) - 1].setSecondMove(as: game.currentHalfMove)
    }
    
    func getPuzzle(difficulty: puzzleDifficulty, index: Int?){
        currentPuzzleDifficulty = difficulty
        attemptCounter = 0
        puzzleFullMovesMade = 0
        switch difficulty{
        case .beginner:
            if model.numBeginnerPuzzlesCompleted > 30{
                for index in (0..<model.beginnerPuzzleList.count){
                    model.beginnerPuzzleList[index].completed = false
                }
            }
            var nextPuzzleIndex = Int.random(in: 0..<model.beginnerPuzzleList.count)
            while model.beginnerPuzzleList[nextPuzzleIndex].completed{
                nextPuzzleIndex = Int.random(in: 0..<model.beginnerPuzzleList.count)
            }
            model.currentPuzzle = nextPuzzleIndex
            currentPuzzle = model.beginnerPuzzleList[model.currentPuzzle]
            print("Puzzle solution, for testing: \(printPuzzleAnswer(puzzle: currentPuzzle!))")
            initializeNewGame(fen: currentPuzzle!.fen, isPuzzle: true)
        case .intermidiate:
            if model.numIntermediatePuzzlesCompleted > 30{
                for index in (0..<model.intermediatePuzzleList.count){
                    model.intermediatePuzzleList[index].completed = false
                }
            }
            var nextPuzzleIndex = Int.random(in: 0..<model.intermediatePuzzleList.count)
            while model.intermediatePuzzleList[nextPuzzleIndex].completed{
                nextPuzzleIndex = Int.random(in: 0..<model.intermediatePuzzleList.count)
            }
            model.currentPuzzle = nextPuzzleIndex
            currentPuzzle = model.intermediatePuzzleList[model.currentPuzzle]
            print("Puzzle solution, for testing: \(printPuzzleAnswer(puzzle: currentPuzzle!))")
            initializeNewGame(fen: currentPuzzle!.fen, isPuzzle: true)
        case .advanced:
            if model.numAdvancedPuzzlesCompleted > 30{
                for index in (0..<model.advancedPuzzleList.count){
                    model.advancedPuzzleList[index].completed = false
                }
            }
            var nextPuzzleIndex = Int.random(in: 0..<model.advancedPuzzleList.count)
            while model.advancedPuzzleList[nextPuzzleIndex].completed{
                nextPuzzleIndex = Int.random(in: 0..<model.advancedPuzzleList.count)
            }
            model.currentPuzzle = nextPuzzleIndex
            currentPuzzle = model.advancedPuzzleList[model.currentPuzzle]
            print("Puzzle solution, for testing: \(printPuzzleAnswer(puzzle: currentPuzzle!))")
            initializeNewGame(fen: currentPuzzle!.fen, isPuzzle: true)
        case .userCreated:
            model.currentPuzzle = index!
            model.userCreatedPuzzles[index!].completed = false
            model.userCreatedPuzzles[index!].failed = false
            currentPuzzle = model.userCreatedPuzzles[index!]
            initializeNewGame(fen: currentPuzzle!.fen, isPuzzle: true)
        case .recent:
            model.currentPuzzle = index!
            model.recentPuzzlesList[index!].completed = false
            model.recentPuzzlesList[index!].failed = false
            currentPuzzle = model.recentPuzzlesList[index!]
            initializeNewGame(fen: currentPuzzle!.fen, isPuzzle: true)
        }
    }
    
    func printPuzzleAnswer(puzzle: Puzzle) -> String{
        var moveText = ""
        for move in puzzle.moveList{
            moveText += move.notation
            moveText += " "
        }
        return moveText
    }
}
