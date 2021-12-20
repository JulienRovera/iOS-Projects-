//
//  ChessPiece.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/9/21.
//

import Foundation
enum pieceColor {
    case white
    case black
}

enum pieceType{
    case pawn
    case rook
    case knight
    case bishop
    case queen
    case king
}
struct ChessPiece: Equatable{
    var color: pieceColor
    var type: pieceType
    var imageName: String
    var abbreviation: String
    var fenCharacter: Character
    static func == (lhs: ChessPiece, rhs: ChessPiece) -> Bool {
        return lhs.type == rhs.type && lhs.color == rhs.color
    }
    
    init(fenCharacter: Character){
        self.fenCharacter = fenCharacter
        if fenCharacter.isLowercase{
            color = .black
        }
        else{
            color = .white
        }
        let standardizedFenCharacter = fenCharacter.uppercased()
        switch(standardizedFenCharacter){
        case "R": type = .rook; abbreviation = "R"
        case "N": type = .knight; abbreviation = "N"
        case "B": type = .bishop; abbreviation = "B"
        case "Q": type = .queen; abbreviation = "Q"
        case "K": type = .king; abbreviation = "K"
        case "P": type = .pawn; abbreviation = ""
        default:
            print("Invalid fen piece passed init chess piece init")
            print(fenCharacter)
            type = .pawn
            abbreviation = ""
            assert(1 == 2)
        }
        imageName = String(piece: fenCharacter, chess: true)
    }
    
    mutating func updateAbbreviation(newType: pieceType){
        switch(newType){
        case .knight: abbreviation = "N"
        case .bishop: abbreviation = "B"
        case .rook: abbreviation = "R"
        case .queen: abbreviation = "Q"
        default:
            abbreviation = ""
            print("promotion move text error")
        }
    }
    static let standard = ChessPiece(fenCharacter: "P")
    static let whiteRook = ChessPiece(fenCharacter: "R")
    static let blackRook = ChessPiece(fenCharacter: "r")
}
