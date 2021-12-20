//
//  Game.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/18/21.
//

import Foundation

struct Game{
    var chessSquareList: [ChessSquare]
    var moveList: [FullMove]
    var viewedHalfMove: Int
    
    var blackKingMated: Bool
    var whiteKingMated: Bool
    var blackKingPosition: Int
    var whiteKingPosition: Int
    var winner: pieceColor?
    var numHalfMoves: Int
    var currentHalfMove: HalfMove
    var selectedPiece: ChessPiece?
    var selectedSquare: ChessSquare?
    var shortCastlingSquare: ChessSquare?
    var longCastlingSquare: ChessSquare?
    var enPassantSquare: ChessSquare?
    var previousDepartureSquare: ChessSquare?
    var previousDestinationSquare: ChessSquare?
    var currentTurn: pieceColor
    var whiteKingMoved: Bool
    var shortWhiteRookMoved: Bool
    var longWhiteRookMoved: Bool
    var blackKingMoved: Bool
    var shortblackRookMoved: Bool
    var longblackRookMoved: Bool
    
    var isPuzzle: Bool
    var isRecording: Bool
    init(fen: String, isPuzzle: Bool){
        chessSquareList = []
        moveList = []
        viewedHalfMove = -1
        numHalfMoves = 0
        blackKingMated = false
        whiteKingMated = false
        blackKingPosition = 4
        whiteKingPosition = 60
        winner = nil
        currentHalfMove = HalfMove(castle: .kingSide, destinationSquare: ChessSquare.standard, piece: ChessPiece.standard)
        selectedPiece = nil
        selectedSquare = nil
        shortCastlingSquare = nil
        longCastlingSquare = nil
        previousDepartureSquare = nil
        previousDestinationSquare = nil
        //currentTurn = .white
        whiteKingMoved = false
        shortWhiteRookMoved = false
        longWhiteRookMoved = false
        blackKingMoved = false
        shortblackRookMoved = false
        longblackRookMoved = false
        self.isPuzzle = isPuzzle
        isRecording = false
        let fenArray = Array(fen)
        var boardPosition: Int = 0
        var fenIndex = 0
        for character in fenArray{
            if(character != " "){
                if(character.isNumber){
                    for _ in 1...Int(String(character))!{
                        chessSquareList.append(ChessSquare(id: boardPosition, fenCharacter: nil))
                        boardPosition += 1
                    }
                }
                else{
                    if(character != "/"){
                        chessSquareList.append(ChessSquare(id: boardPosition, fenCharacter: character))
                        boardPosition += 1
                    }
                }
            }
            else{
                fenIndex += 1
                break
            }
            fenIndex += 1
        }
        switch fenArray[fenIndex]{
        case "w": currentTurn = .white
        case "b": currentTurn = .black
        default: print("Fen error, unable to get current move")
                 currentTurn = .white
        }
    }
    
    mutating func beginRecording(){
        isRecording = true
        moveList = []
        viewedHalfMove = -1
        numHalfMoves = 0
    }
    
    mutating func checkCastlePossible(){
        /*witch game.selectedSquare!.number{
        case 60: game.whiteKingMoved = true
        case 56: game.longWhiteRookMoved = true
        case 63: game.shortWhiteRookMoved = true
        case 4: game.blackKingMoved = true
        case 0: game.longblackRookMoved = true
        case 7: game.shortblackRookMoved = true
        default: break
        }*/
        if chessSquareList[0].piece?.type != .rook && chessSquareList[0].piece?.color != .black{
            longblackRookMoved = true
        }
        if chessSquareList[7].piece?.type != .rook && chessSquareList[0].piece?.color != .black{
            shortblackRookMoved = true
        }
        if chessSquareList[4].piece?.type != .king && chessSquareList[0].piece?.color != .black{
            blackKingMoved = true
        }
        if chessSquareList[56].piece?.type != .rook && chessSquareList[0].piece?.color != .white{
            longWhiteRookMoved = true
        }
        if chessSquareList[60].piece?.type != .king && chessSquareList[0].piece?.color != .white{
            whiteKingMoved = true
        }
        if chessSquareList[63].piece?.type != .rook && chessSquareList[0].piece?.color != .white{
            shortWhiteRookMoved = true
        }
    }
}
