//
//  chessSquareRow.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/9/21.
//

import Foundation
import SwiftUI

struct ChessSquareRow: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    var row: Int
    var body: some View{
        HStack(spacing: 0){
            ForEach((0...7), id: \.self){i in
                ChessSquareView(square: chessTacticsManager.game.chessSquareList[(8*row) + i])
            }
        }
    }
}
