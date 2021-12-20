//
//  Puzzle.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/17/21.
//

import Foundation

enum puzzleDifficulty{
    case beginner
    case intermidiate
    case advanced
    case userCreated
    case recent
}
struct Puzzle: Codable, Hashable, Identifiable{
    static func == (lhs: Puzzle, rhs: Puzzle) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
    
    let fen: String
    let moves: [String]
    let moveList: [FullMove]
    var attempts: Int
    let numHalfMoves: Int
    var completed: Bool
    var failed: Bool
    var id = UUID()
    var name: String
    var listIndex: Int?
    
    init(fen: String, moveList: [FullMove], numHalfMoves: Int, name: String, listIndex: Int?){
        self.fen = fen
        var tempMoves: [String] = []
        for move in moveList{
            tempMoves.append(move.firstMove.notation)
            if move.secondMove != nil{
                tempMoves.append(move.secondMove!.notation)
            }
        }
        moves = tempMoves
        self.moveList = moveList
        attempts = 0
        self.numHalfMoves = numHalfMoves
        completed = false
        failed = false
        self.name = name
        self.listIndex = listIndex
    }
    
    static let standard = Puzzle(fen: ChessConstants.startingFen, moveList: [], numHalfMoves: 0, name: "Standard", listIndex: nil)
}

extension Puzzle{
    enum CodingKeys: CodingKey{
        case FEN
        case moves
        case name
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do{
            name = try values.decode(String.self, forKey: .name)
        }catch{
            name = id.uuidString
        }
        do{
            fen = try values.decode(String.self, forKey: .FEN)
        }catch{
            fen = ChessConstants.startingFen
        }
        moves = try values.decode([String].self, forKey: .moves)
        
        attempts = 0
        var tempMoveList: [FullMove] = []
        var tempHalfMoves = 0
        for index in stride(from: 0, to: moves.count, by: 2){
            tempHalfMoves += 1
            var newHalfMove = HalfMove(newNotation: moves[index])
            var newFullMove = FullMove(number: index/2+1, firstMove: newHalfMove)
            if index + 1 < moves.count{
                tempHalfMoves += 1
                newHalfMove = HalfMove(newNotation: moves[index+1])
                newFullMove.setSecondMove(as: newHalfMove)
            }
            tempMoveList.append(newFullMove)
        }
        moveList = tempMoveList
        numHalfMoves = tempHalfMoves
        completed = false
        failed = false
        listIndex = nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(fen, forKey: .FEN)
        try container.encode(moves, forKey: .moves)
    }
}
