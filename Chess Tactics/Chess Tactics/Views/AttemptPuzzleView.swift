//
//  AttemptPuzzleView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/17/21.
//

import Foundation
import SwiftUI

struct AttemptPuzzleView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    
    var body: some View{
        AttemptsView()
        GameAssetsView(includeHintButton: true)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Puzzles")
                }
            }
    }
}
