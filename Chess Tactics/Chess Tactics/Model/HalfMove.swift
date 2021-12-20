//
//  HalfMove.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/16/21.
//

import Foundation

enum castleType{
    case kingSide
    case queenSide
    case none
}


struct HalfMove: Equatable{
    static func == (lhs: HalfMove, rhs: HalfMove) -> Bool {
        return lhs.notation == rhs.notation
    }
    
    var piece: ChessPiece
    var capturedPiece: ChessPiece?
    var departureSquare: ChessSquare
    var destinationSquare: ChessSquare
    var departureRank: Int?
    var departureFile: String?
    var check: Bool
    var mate: Bool
    var promotion: Bool
    var enPassant: Bool
    var promotedTo: ChessPiece?
    var castle: castleType
    var notation: String
    
    
   
    init(piece: ChessPiece, capturedPiece: ChessPiece?, departureSquare: ChessSquare, destinationSquare: ChessSquare, check: Bool, mate: Bool){
        self.piece = piece
        self.capturedPiece = capturedPiece
        self.departureSquare = departureSquare
        self.destinationSquare = destinationSquare
        self.check = check
        self.mate = mate
        departureRank = nil
        departureFile = nil
        promotion = false
        promotedTo = nil
        castle = .none
        enPassant = false
        
        var moveText = piece.abbreviation
        if capturedPiece != nil{
            if piece.type == .pawn{
                moveText += String(number: departureSquare.number, chess: false)
            }
            moveText += "x"
        }
        moveText += destinationSquare.name
        notation = moveText
    }
    
    init(newNotation: String){
        notation = newNotation
        var notationArray = Array(notation)
        if notationArray.last == "+" || notationArray.last == "#"{
            notationArray.removeLast()
        }
        notation = String(notationArray)
        piece = ChessPiece.standard
        enPassant = false
        destinationSquare = ChessSquare.standard
        if notationArray[0].isUppercase{
            switch notationArray[0]{
            case "R": piece.type = .rook
            case "N": piece.type = .knight
            case "B": piece.type = .bishop
            case "Q": piece.type = .queen
            case "K": piece.type = .king
            default:
                print("error assigning piece type from move notation")
            }
            let squareName = String(notationArray[notationArray.count - 2]) + String(notationArray[notationArray.count - 1])
            destinationSquare = ChessSquare(id: Int(squareName: squareName), fenCharacter: notationArray[0])
        }
        else{
            piece.type = .pawn
            var squareName = String(notationArray[0]) + String(notationArray[1])
            if notationArray[1] == "x"{
                squareName = String(notationArray[2]) + String(notationArray[3])
            }
            destinationSquare = ChessSquare(id: Int(squareName: squareName), fenCharacter: "P")
        }
        
        
        capturedPiece = nil
        departureSquare = ChessSquare.standard
        check = false
        mate = false
        departureRank = nil
        departureFile = nil
        
        if notationArray.count > 3 && piece.type != .pawn && notationArray[1] != "x"{
            if notationArray[1].isNumber{
                departureRank = Int(String(notationArray[1]))
            }
            else{
                departureFile = String(notationArray[1])
                if notationArray.count > 4 && notationArray[2] != "x"{
                    departureRank = Int(String(notationArray[2]))
                }
            }
        }
        
        promotion = false
        promotedTo = nil
        castle = .none
    }
    
    init(castle: castleType, destinationSquare: ChessSquare, piece: ChessPiece){
        self.piece = piece
        capturedPiece = nil
        departureSquare = ChessSquare.standard
        self.destinationSquare = destinationSquare
        check = false
        mate = false
        departureRank = nil
        departureFile = nil
        promotion = false
        promotedTo = nil
        enPassant = false
        self.castle = castle
        
        switch castle{
        case .kingSide: notation = "O-O"
        case .queenSide: notation = "O-O-O"
        default: notation = "Castling Error"
        }
    }
    
    mutating func captureAPiece(capturedPiece: ChessPiece?){
        self.capturedPiece = capturedPiece
        updateNotation()
    }
    
    mutating func updatePromotion(promotion: Bool, piece: ChessPiece){
        self.promotion = promotion
        promotedTo = piece
        updateNotation()
    }
    
    mutating func updateDepartureRank(to newDepartureRank: Int){
        departureRank = newDepartureRank
        updateNotation()
    }
    
    mutating func updateDepartureFile(to newDepartureFile: String){
        departureFile = newDepartureFile
        updateNotation()
    }
    mutating func updateNotation(){
        var moveText = piece.abbreviation
        if departureFile != nil{
            moveText += departureFile!
        }
        if departureRank != nil{
            moveText += String(departureRank!)
        }
        if capturedPiece != nil{
            if piece.type == .pawn{
                moveText += String(number: departureSquare.number, chess: false)
            }
            moveText += "x"
        }
        moveText += destinationSquare.name
        if promotion{
            moveText += "=\(promotedTo!.abbreviation)"
        }
        notation = moveText
    }
    
    mutating func updateEnPassant(to value: Bool){
        enPassant = value
    }
}
