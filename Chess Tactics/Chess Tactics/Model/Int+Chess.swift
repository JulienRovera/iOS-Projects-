//
//  Int+Chess.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/18/21.
//

import Foundation
extension Int{
    init(squareName: String){
        switch squareName{
        case "a8": self = 0
        case "b8": self = 1
        case "c8": self = 2
        case "d8": self = 3
        case "e8": self = 4
        case "f8": self = 5
        case "g8": self = 6
        case "h8": self = 7
        case "a7": self = 8
        case "b7": self = 9
        case "c7": self = 10
        case "d7": self = 11
        case "e7": self = 12
        case "f7": self = 13
        case "g7": self = 14
        case "h7": self = 15
        case "a6": self = 16
        case "b6": self = 17
        case "c6": self = 18
        case "d6": self = 19
        case "e6": self = 20
        case "f6": self = 21
        case "g6": self = 22
        case "h6": self = 23
        case "a5": self = 24
        case "b5": self = 25
        case "c5": self = 26
        case "d5": self = 27
        case "e5": self = 28
        case "f5": self = 29
        case "g5": self = 30
        case "h5": self = 31
        case "a4": self = 32
        case "b4": self = 33
        case "c4": self = 34
        case "d4": self = 35
        case "e4": self = 36
        case "f4": self = 37
        case "g4": self = 38
        case "h4": self = 39
        case "a3": self = 40
        case "b3": self = 41
        case "c3": self = 42
        case "d3": self = 43
        case "e3": self = 44
        case "f3": self = 45
        case "g3": self = 46
        case "h3": self = 47
        case "a2": self = 48
        case "b2": self = 49
        case "c2": self = 50
        case "d2": self = 51
        case "e2": self = 52
        case "f2": self = 53
        case "g2": self = 54
        case "h2": self = 55
        case "a1": self = 56
        case "b1": self = 57
        case "c1": self = 58
        case "d1": self = 59
        case "e1": self = 60
        case "f1": self = 61
        case "g1": self = 62
        case "h1": self = 63
        default: self = 0
            print("error initializing int from square name")
            print(squareName)
        }
    }
}
