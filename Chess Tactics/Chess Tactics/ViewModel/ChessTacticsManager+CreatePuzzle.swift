//
//  ChessTacticsManager+CreatePuzzle.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 12/6/21.
//

import Foundation

extension ChessTacticsManager{
    func beginRecording(){
        setAllIllegal()
        currentFen = getCurrentFen()
        game.beginRecording()
    }
    
    func cancelRecording(){
        initializeNewGame(fen: ChessConstants.startingFen, isPuzzle: false)
    }
    
    func finishRecording(newPuzzleName: String){
        let newPuzzle = Puzzle(fen: currentFen, moveList: game.moveList, numHalfMoves: game.numHalfMoves, name: newPuzzleName, listIndex: model.userCreatedPuzzles.count)
        model.userCreatedPuzzles.append(newPuzzle)
        initializeNewGame(fen: ChessConstants.startingFen, isPuzzle: false)
    }
    
    func getCurrentFen() -> String{
        var fenString = ""
        var emptySpaces = 0
        var rowOffset = 0
        var currentSquareNumber = 0
        var currentSquare = ChessSquare.standard
        for row in 0...7{
            rowOffset = 8 * row
            for square in 0...7{
                currentSquareNumber = rowOffset + square
                currentSquare = game.chessSquareList[currentSquareNumber]
                if let currentPiece = currentSquare.piece{
                    if emptySpaces > 0{
                        fenString += String(emptySpaces)
                    }
                    fenString += String(currentPiece.fenCharacter)
                    emptySpaces = 0
                }
                else{
                    emptySpaces += 1
                }
            }
            if emptySpaces > 0{
                fenString += String(emptySpaces)
            }
            emptySpaces = 0
            if row < 7{
                fenString += "/"
            }
        }
        
        fenString += " "
        if game.currentTurn == .white{
            fenString += "w"
        }
        else{
            fenString += "b"
        }
        return fenString
    }
}
