//
//  ChessConstants.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/9/21.
//

import Foundation

struct ChessConstants{
    static let startingFen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    static let whitePawnStartingPos = [48, 49, 50, 51, 52, 53, 54, 55]
    static let blackPawnStartingPos = [8, 9, 10, 11, 12, 13, 14, 15]
    static let eighthRank = [0, 1, 2, 3, 4, 5,6 ,7]
    static let firstRank = [56, 57, 58, 59, 60, 61, 62, 63]
    static let whiteKingStartingPos = 60
    static let blackKingStartingPos = 4
    static let whiteRookStartingPos = [56, 63]
    static let blackRookStartingPos = [0, 7]
}
