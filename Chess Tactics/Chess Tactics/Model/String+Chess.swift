//
//  String+ChessNumber.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/9/21.
//

import Foundation

extension String{
    init(number: Int, chess: Bool){
        let letterNumber = number % 8
        var squareNumber = 8-((number+1) / 8)
        
        var letter: String{
            switch(letterNumber){
            case 0: return "a"
            case 1: return "b"
            case 2: return "c"
            case 3: return "d"
            case 4: return "e"
            case 5: return "f"
            case 6: return "g"
            case 7: return "h"
            default:
                print("error getting algebraic notation")
                return "z"
            }
        }
        if(letter == "h"){
            squareNumber += 1
        }
        if chess == true{
            self = "\(letter)\(squareNumber)"
        }
        else{
            self = letter
        }
    }
    
    init(piece: Character, chess: Bool){
        switch(piece){
        case "r": self = "blackRook"
        case "b": self = "blackBishop"
        case "n": self = "blackKnight"
        case "q": self = "blackQueen"
        case "k": self = "blackKing"
        case "p": self = "blackPawn"
        case "R": self = "whiteRook"
        case "B": self = "whiteBishop"
        case "N": self = "whiteKnight"
        case "Q": self = "WhiteQueen"
        case "K": self = "whiteKing"
        case "P": self = "whitePawn"
        default:
            print("invalid fen piece code")
            self = "whitePawn"
        }
    }
}
