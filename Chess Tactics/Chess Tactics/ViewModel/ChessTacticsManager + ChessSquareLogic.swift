//
//  ChessTacticsManager + ChessSquareLogic.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/14/21.
//

import Foundation

extension ChessTacticsManager{
    func setAllIllegal(){
        for index in game.chessSquareList.indices{
            game.chessSquareList[index].legalSquare = false
        }
    }
    
    func squareTapped(square: ChessSquare){
        
        setAllIllegal()
        if square.legalSquare == false{
            game.selectedPiece = nil
            game.selectedSquare = nil
            return
        }
        
        switch game.selectedSquare!.number{
        case 60: game.whiteKingMoved = true
        case 56: game.longWhiteRookMoved = true
        case 63: game.shortWhiteRookMoved = true
        case 4: game.blackKingMoved = true
        case 0: game.longblackRookMoved = true
        case 7: game.shortblackRookMoved = true
        default: break
        }
        game.previousDepartureSquare = game.selectedSquare
        game.previousDestinationSquare = square
        game.currentHalfMove = HalfMove(piece: game.selectedPiece!, capturedPiece: nil, departureSquare: game.selectedSquare!, destinationSquare: square, check: false, mate: false)
        
        if game.selectedPiece!.type != .pawn && game.selectedPiece!.type != .king{
            checkUniqueMove(square: square)
        }
        
        if game.selectedPiece!.type == .pawn{
            checkForPawnCases(square: square)
            if promotingPiece{
                return
            }
        }
        else{
            game.enPassantSquare = nil
        }
        
        changeTurn()
        
        if game.selectedPiece!.type == .king{
            if game.selectedPiece!.color == .white{
                game.whiteKingPosition = square.number
                //print("white king moved")
                //print(square.name)
            }
            else{
                game.blackKingPosition = square.number
                //print("black king moved")
                //print(square.name)
            }
        }
        if game.shortCastlingSquare != nil{
            if square.number == game.shortCastlingSquare!.number{
                game.currentHalfMove = HalfMove(castle: .kingSide, destinationSquare: square, piece: game.selectedPiece!)
                castle(square: square, newRookSquare: square.number - 1, oldRookSquare: square.number + 1)
                //print(game.currentHalfMove.notation)
                game.numHalfMoves += 1
                updateMoveList()
                return
            }
        }
        
        if game.longCastlingSquare != nil{
            if square.number == game.longCastlingSquare!.number{
                game.currentHalfMove = HalfMove(castle: .queenSide, destinationSquare: square, piece: game.selectedPiece!)
                castle(square: square, newRookSquare: square.number + 1, oldRookSquare: square.number - 2)
                //print(game.currentHalfMove.notation)
                game.numHalfMoves += 1
                updateMoveList()
                return
            }
        }
        
        movePiece(square: square)
        //print(game.currentHalfMove.notation)
        game.numHalfMoves += 1
        //print(game.currentHalfMove.notation)
        updateMoveList()
    }
    
    func castle(square: ChessSquare, newRookSquare: Int, oldRookSquare: Int){
        game.chessSquareList[square.number].piece = game.selectedPiece
        game.chessSquareList[newRookSquare].piece = game.chessSquareList[oldRookSquare].piece!
        game.chessSquareList[game.selectedSquare!.number].piece = nil
        game.chessSquareList[oldRookSquare].piece = nil
        game.selectedSquare = nil
        game.selectedPiece = nil
        return
    }
    
    func changeTurn(){
        if game.currentTurn == .white{
            game.currentTurn = .black
        }
        else{
            game.currentTurn = .white
        }
    }
    
    func movePiece(square: ChessSquare){
        game.chessSquareList[game.selectedSquare!.number].piece = nil
        if !game.currentHalfMove.enPassant{
            game.currentHalfMove.captureAPiece(capturedPiece: game.chessSquareList[square.number].piece)
        }
        if game.chessSquareList[square.number].piece?.type == .king{
            disableBoard = true
            game.winner = game.chessSquareList[square.number].piece?.color
            if game.winner == .black{
                game.currentHalfMove.notation = game.currentHalfMove.notation + " 1-0"
            }
            else{
                game.currentHalfMove.notation = game.currentHalfMove.notation + " 0-1"
            }
        }
        game.chessSquareList[square.number].piece = game.selectedPiece!
        game.selectedSquare = nil
        game.selectedPiece = nil
        //check if the king is in check at this point it is the other color's turn
        //checkIfCheck()
    }
    
    func promotePiece(newType: pieceType, newImage: String){
        //print("Hello")
        game.chessSquareList[game.selectedSquare!.number].piece!.type = newType
        game.chessSquareList[game.selectedSquare!.number].piece!.imageName = newImage
        game.chessSquareList[game.selectedSquare!.number].piece!.updateAbbreviation(newType: newType)
        game.currentHalfMove.updatePromotion(promotion: true, piece: game.chessSquareList[game.selectedSquare!.number].piece!)
        game.numHalfMoves += 1
        updateMoveList()
        game.selectedSquare = nil
        disableBoard = false
        promotingPiece = false
        changeTurn()
    }
    
    func checkForPawnCases(square: ChessSquare){
        var finalRank: [Int]
        var movementCoefficient = -1
        
        if game.selectedPiece!.color == .white{
            finalRank = ChessConstants.eighthRank
        }
        else{
            finalRank = ChessConstants.firstRank
            movementCoefficient = 1
        }
        
        if game.enPassantSquare != nil{
            if square.number == game.enPassantSquare!.number{
                game.currentHalfMove.captureAPiece(capturedPiece: game.chessSquareList[square.number - (movementCoefficient*8)].piece)
                //print(game.currentHalfMove.capturedPiece ?? "no piece captured")
                //print(game.chessSquareList[square.number - movementCoefficient * 8].name)
                //print(game.currentHalfMove.notation)
                game.currentHalfMove.updateEnPassant(to: true)
                
                game.chessSquareList[square.number - (movementCoefficient*8)].piece = nil
               //print(game.currentHalfMove.notation)
            }
            if square.number != game.enPassantSquare!.number + (movementCoefficient*8){
                game.enPassantSquare = nil
            }
        }
        
        if finalRank.contains(square.number){
            disableBoard = true
            promotingPiece = true
            movePiece(square: square)
            game.selectedSquare = game.chessSquareList[square.number]
        }
        
        if square.number - game.selectedSquare!.number == 16{
            game.enPassantSquare = game.chessSquareList[square.number - 8]
        }
        if square.number - game.selectedSquare!.number == -16{
            game.enPassantSquare = game.chessSquareList[square.number + 8]
        }
    }
    
}
