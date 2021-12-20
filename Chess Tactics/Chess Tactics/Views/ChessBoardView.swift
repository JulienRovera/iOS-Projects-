//
//  ChessBoardView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/2/21.
//

import Foundation
import SwiftUI

struct ChessBoardView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    var body: some View{
        VStack(spacing: 0){
            ForEach((0...7), id: \.self){i in
                ChessSquareRow(row: i)
            }
        }
    }
}
