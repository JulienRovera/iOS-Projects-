//
//  UserCreatedPuzzlesView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 12/6/21.
//

import Foundation
import SwiftUI

struct UserCreatedPuzzlesView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    var difficulty: puzzleDifficulty
    var puzzleList: [Puzzle] {
        switch difficulty{
        case .userCreated: return chessTacticsManager.model.userCreatedPuzzles.reversed()
        default: return chessTacticsManager.model.recentPuzzlesList
    }}
    var body: some View{
        if puzzleList.count > 0{
            List{
                ForEach(puzzleList.indices, id: \.self) { index in
                    NavigationLink(destination: AttemptPuzzleView().onAppear{
                        chessTacticsManager.getPuzzle(difficulty: difficulty, index: index)
                    }){
                        Text(puzzleList[index].name)
                    }
                }
            }.toolbar{
                ToolbarItem(placement: .principal){
                    Text("Your Puzzles")
                }
            }
        }
        else{
            Text("No puzzles to display")
                .toolbar{
                    ToolbarItem(placement: .principal){
                        Text("Your Puzzles")
                    }
                }
        }
    }
}
