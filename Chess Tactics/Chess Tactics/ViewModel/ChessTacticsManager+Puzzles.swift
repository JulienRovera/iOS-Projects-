//
//  ChessTacticsManager+Puzzles.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/18/21.
//

import Foundation
//model.puzzleList[model.currentPuzzle].moveList[(game.numHalfMoves/2) - 1].firstMove
extension ChessTacticsManager{
    func checkIfCorrectMove(){
        var correctHalfMove = HalfMove(castle: .none, destinationSquare: ChessSquare.standard, piece: ChessPiece.standard)
        //print(puzzleFullMovesMade)
        if game.numHalfMoves % 2 == 1{
            correctHalfMove = currentPuzzle!.moveList[game.numHalfMoves/2].firstMove
        }
        else{
            correctHalfMove = currentPuzzle!.moveList[puzzleFullMovesMade].secondMove!
            puzzleFullMovesMade += 1
        }
        
        if game.currentHalfMove == correctHalfMove{
            if game.numHalfMoves == currentPuzzle!.numHalfMoves{
                puzzleButtonDisabled = false
                puzzleAttempts[attemptCounter] = .correct
                disableBoard = true
                
                
                //important
                markPuzzleAsCompleted(failed: false)
                if currentPuzzleDifficulty != .userCreated{
                    puzzleButtonText = "Next"
                    return
                }
                puzzleButtonText = "Solved"
                puzzleButtonSuperDisabled = true
                return
            }
            makeOpponentsMove()
            if game.numHalfMoves == currentPuzzle!.numHalfMoves{
                puzzleButtonDisabled = false
                puzzleAttempts[attemptCounter] = .correct
                disableBoard = true
                
                
                //important
                markPuzzleAsCompleted(failed: false)
                if currentPuzzleDifficulty != .userCreated{
                    puzzleButtonText = "Next"
                    return
                }
                puzzleButtonText = "Solved"
                puzzleButtonSuperDisabled = true
                return
            }
        }
        else{
            puzzleAttempts[attemptCounter] = .incorrect
            disableBoard = true
            puzzleButtonDisabled = false
            if attemptCounter == 2{
                puzzleButtonText = "Solution"
                
                
                //important
                markPuzzleAsCompleted(failed: true)
            }
        }
    }
    
    func makeOpponentsMove(){
        let nextHalfMoveNum = game.numHalfMoves + 1
        var nextHalfMove = HalfMove(castle: .kingSide, destinationSquare: ChessSquare.standard, piece: ChessPiece.standard)
        if nextHalfMoveNum % 2 == 1{
            nextHalfMove = currentPuzzle!.moveList[puzzleFullMovesMade].firstMove
        }
        else{
            nextHalfMove = currentPuzzle!.moveList[puzzleFullMovesMade].secondMove!
        }
        
        let destinationIndex = nextHalfMove.destinationSquare.number
        nextHalfMove.piece.color = game.currentTurn
        
        for index in game.chessSquareList.indices{
            game.currentTurn = nextHalfMove.piece.color
            if game.chessSquareList[index].piece?.type == nextHalfMove.piece.type && game.chessSquareList[index].piece?.color == nextHalfMove.piece.color{
                game.selectedSquare = nil
                findLegalMoves(square: game.chessSquareList[index])
                //print("destination index: \(destinationIndex)")
                //print("next half move num: \(nextHalfMoveNum)")
                //print("next half move: \(nextHalfMove.notation)")
                if game.chessSquareList[destinationIndex].legalSquare{
                    if(nextHalfMove.departureRank != nil || nextHalfMove.departureFile != nil){
                        //print("ended up in here for some reason")
                        if nextHalfMove.departureRank != nil && nextHalfMove.departureFile != nil{
                            if nextHalfMove.departureRank == game.chessSquareList[index].rank && nextHalfMove.departureFile == game.chessSquareList[index].file{
                                squareTapped(square: game.chessSquareList[destinationIndex])
                                break
                            }
                        }
                        else{
                            if nextHalfMove.departureRank != nil{
                                if nextHalfMove.departureRank == game.chessSquareList[index].rank{
                                    squareTapped(square: game.chessSquareList[destinationIndex])
                                    break
                                }
                            }
                            else{
                                if nextHalfMove.departureFile != nil{
                                    if nextHalfMove.departureFile == game.chessSquareList[index].file{
                                        squareTapped(square: game.chessSquareList[destinationIndex])
                                        break
                                    }
                                }
                            }
                        }
                    }
                    else{
                        //print("trying to tap the square")
                        squareTapped(square: game.chessSquareList[destinationIndex])
                        break
                    }
                }
            }
        }
        game.numHalfMoves = nextHalfMoveNum
        if nextHalfMoveNum % 2 == 0{
            puzzleFullMovesMade += 1
        }
    }
    
    func markPuzzleAsCompleted(failed: Bool){
        switch(currentPuzzleDifficulty){
        case .beginner:
            if failed{
                model.beginnerPuzzleList[model.currentPuzzle].failed = failed
                break
            }
            model.beginnerPuzzleList[model.currentPuzzle].completed = true
            model.numBeginnerPuzzlesCompleted += 1
        case .intermidiate:
            if failed{
                model.intermediatePuzzleList[model.currentPuzzle].failed = failed
                break
            }
            model.intermediatePuzzleList[model.currentPuzzle].completed = true
            model.numIntermediatePuzzlesCompleted += 1
        case .advanced:
            if failed{
                model.advancedPuzzleList[model.currentPuzzle].failed = failed
                break
            }
            model.advancedPuzzleList[model.currentPuzzle].completed = true
            model.numAdvancedPuzzlesCompleted += 1
        case .userCreated:
            if failed{
                model.userCreatedPuzzles[model.currentPuzzle].failed = failed
                break
            }
            model.userCreatedPuzzles[model.currentPuzzle].completed = true
        case .recent:
            if failed{
                model.recentPuzzlesList[model.currentPuzzle].failed = failed
                break
            }
            model.recentPuzzlesList[model.currentPuzzle].completed = true
        }
    }
    
    func displaySolution(){
        var puzzleList: [Puzzle] {
            switch currentPuzzleDifficulty{
            case .beginner:
                return model.beginnerPuzzleList
            case .intermidiate:
                return model.intermediatePuzzleList
            case .advanced:
                return model.advancedPuzzleList
            case .userCreated:
                return model.userCreatedPuzzles
            case .recent:
                return model.recentPuzzlesList
            }
        }
        for _ in (0..<puzzleList[model.currentPuzzle].numHalfMoves){
            makeOpponentsMove()
        }
        for _ in (0..<puzzleList[model.currentPuzzle].numHalfMoves){
            viewPreviousMove()
        }
    }
}
