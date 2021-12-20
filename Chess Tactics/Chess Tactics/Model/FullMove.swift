//
//  FullMove.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/16/21.
//

import Foundation

struct FullMove: Hashable{
    var firstMove: HalfMove
    var secondMove: HalfMove?
    var number: Int
    var notation: String
    var id = UUID()
    init(number: Int, firstMove: HalfMove){
        self.number = number
        self.firstMove = firstMove
        secondMove = nil
        
        notation = "\(number). \(firstMove.notation)"
    }
    
    mutating func setSecondMove(as nextMove: HalfMove?){
        secondMove = nextMove
        notation = "\(number). \(firstMove.notation) \(nextMove!.notation)"
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
}
