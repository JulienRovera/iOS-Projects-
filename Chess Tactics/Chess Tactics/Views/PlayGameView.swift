//
//  PlayGameView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/2/21.
//

import Foundation
import SwiftUI

struct PlayGameView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    var body: some View{
        GameAssetsView(includeHintButton: false)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Play Game")
                }
            }
    }
}
