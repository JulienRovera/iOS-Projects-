//
//  ChessTacticsManager+MoveViewing.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/29/21.
//

import Foundation

extension ChessTacticsManager{
    
    func viewPreviousMove(){
        setAllIllegal()
        game.enPassantSquare = nil
        // if == 1 that means you are looking at second half move
        var viewedMove: HalfMove
        var previousMove: HalfMove? = nil
        if game.viewedHalfMove % 2 == 1{
            viewedMove = game.moveList[game.viewedHalfMove/2].secondMove!
            previousMove = game.moveList[game.viewedHalfMove/2].firstMove
        }
        else{
            viewedMove = game.moveList[game.viewedHalfMove/2].firstMove
            if game.viewedHalfMove != 0{
                previousMove = game.moveList[(game.viewedHalfMove-1)/2].secondMove
            }
        }
        game.viewedHalfMove -= 1
        changeTurn()
        if viewedMove.castle != .none{
            var kingOffset = 2
            var rookOffset = -2
            var rookType = ChessPiece.blackRook
            if viewedMove.castle == .kingSide{
                kingOffset = -2
                rookOffset = 1
                if viewedMove.piece.color == .white{
                    rookType = ChessPiece.whiteRook
                    game.whiteKingMoved = false
                    game.shortWhiteRookMoved = false
                }
                else{
                    game.blackKingMoved = false
                    game.shortblackRookMoved = false
                }
            }
            else{
                if viewedMove.piece.color == .white{
                    rookType = ChessPiece.whiteRook
                    game.whiteKingMoved = false
                    game.longWhiteRookMoved = false
                }
                else{
                    game.blackKingMoved = false
                    game.longblackRookMoved = false
                }
            }
            
            game.chessSquareList[viewedMove.destinationSquare.number + kingOffset].piece = viewedMove.piece
            game.chessSquareList[viewedMove.destinationSquare.number + rookOffset].piece = rookType
            game.chessSquareList[viewedMove.destinationSquare.number].piece = nil
            game.chessSquareList[viewedMove.destinationSquare.number + (kingOffset/2)].piece = nil
            if previousMove != nil{
                game.previousDepartureSquare = previousMove!.departureSquare
                game.previousDestinationSquare = previousMove!.destinationSquare
            }
            else{
                game.previousDepartureSquare = nil
                game.previousDestinationSquare = nil
            }
            return
        }
        
        game.chessSquareList[viewedMove.destinationSquare.number].piece = viewedMove.capturedPiece
        if viewedMove.enPassant{
            var squareBehind = 8
            var capturedPawn = ChessPiece(fenCharacter: "p")
            if viewedMove.piece.color == .black{
                squareBehind = -8
                capturedPawn = ChessPiece(fenCharacter: "P")
            }
            game.chessSquareList[viewedMove.destinationSquare.number + squareBehind].piece = capturedPawn
            game.chessSquareList[viewedMove.destinationSquare.number].piece = nil
            game.enPassantSquare = game.chessSquareList[viewedMove.destinationSquare.number]
        }
        game.chessSquareList[viewedMove.departureSquare.number].piece = viewedMove.piece
        if previousMove != nil{
            game.previousDepartureSquare = previousMove!.departureSquare
            game.previousDestinationSquare = previousMove!.destinationSquare
        }
        else{
            game.previousDepartureSquare = nil
            game.previousDestinationSquare = nil
        }
    }
    
    func viewNextMove(){
        game.enPassantSquare = nil
        game.viewedHalfMove += 1
        var viewedMove: HalfMove
        if game.viewedHalfMove % 2 == 1{
            viewedMove = game.moveList[game.viewedHalfMove/2].secondMove!
        }
        else{
            viewedMove = game.moveList[game.viewedHalfMove/2].firstMove
        }
        changeTurn()
        if viewedMove.castle != .none{
            var kingOffset = -2
            var rookOffset = 1
            var rookPos = -1
            var rookType = ChessPiece.blackRook
            game.shortblackRookMoved = true
            game.blackKingMoved = true
            if viewedMove.piece.color == .white{
                rookType = ChessPiece.whiteRook
                game.shortblackRookMoved = false
                game.blackKingMoved = false
                game.shortWhiteRookMoved = true
                game.whiteKingMoved = true
            }
            if viewedMove.castle == .queenSide{
                kingOffset = 2
                rookOffset = -2
                rookPos = 1
            }
            game.chessSquareList[viewedMove.destinationSquare.number].piece = viewedMove.piece
            game.chessSquareList[viewedMove.destinationSquare.number + rookPos].piece = rookType
            game.chessSquareList[viewedMove.destinationSquare.number + kingOffset].piece = nil
            game.chessSquareList[viewedMove.destinationSquare.number + rookOffset].piece = nil
            game.previousDepartureSquare = viewedMove.departureSquare
            game.previousDestinationSquare = viewedMove.destinationSquare
            return
        }
        
        if viewedMove.enPassant{
            var squareBehind = 8
            if viewedMove.piece.color == .black{
                squareBehind = -8
            }
            game.chessSquareList[viewedMove.destinationSquare.number + squareBehind].piece = nil
            //game.enPassantSquare = nil
        }
        let movementDistance = viewedMove.destinationSquare.number - viewedMove.departureSquare.number
        if viewedMove.piece.type == .pawn && abs(movementDistance) == 16{
            game.enPassantSquare = game.chessSquareList[viewedMove.departureSquare.number + movementDistance / 2]
        }
        
        if let promotionPiece = viewedMove.promotedTo{
            game.chessSquareList[viewedMove.destinationSquare.number].piece = promotionPiece
        }
        else{
            game.chessSquareList[viewedMove.destinationSquare.number].piece = viewedMove.piece
        }
        game.chessSquareList[viewedMove.departureSquare.number].piece = nil
        game.previousDepartureSquare = viewedMove.departureSquare
        game.previousDestinationSquare = viewedMove.destinationSquare
    }
}
