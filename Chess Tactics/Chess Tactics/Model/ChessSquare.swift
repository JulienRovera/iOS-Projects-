//
//  ChessSquare.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/9/21.
//

import Foundation

enum chessSquareColor{
    case light
    case dark
}

struct ChessSquare{
    var number: Int
    var rank: Int
    var file: String
    var name: String
    var piece: ChessPiece?
    var color: chessSquareColor
    var legalSquare: Bool
    
    init(id: Int, fenCharacter: Character?){
        number = id
        name = String(number: id, chess: true)
        file = String(number: id, chess: false)
        legalSquare = false
        let row = id / 8
        if(row % 2 == 0){
            if(id % 2 == 0){
                color = .light
            }
            else{
                color = .dark
            }
        }
        else{
            if(id % 2 == 0){
                color = .dark
            }
            else{
                color = .light
            }
        }
        if(fenCharacter != nil){
            piece = ChessPiece(fenCharacter: fenCharacter!)
        }
        rank = 8 - row
    }
    
    static let standard = ChessSquare(id: 0, fenCharacter: "P")
}
