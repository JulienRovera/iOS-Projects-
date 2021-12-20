//
//  PuzzlesView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/2/21.
//

import Foundation
import SwiftUI

struct PuzzlesView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    @State var isShowingIntermidiatePuzzle = false
    @State var isShowingBeginnerPuzzle = false
    @State var isShowingAdvancedPuzzle = false
    var body: some View{
        VStack{
            Text("Select Difficulty")
            NavigationLink(destination: AttemptPuzzleView(), isActive: $isShowingBeginnerPuzzle){
                Button(action: {chessTacticsManager.getPuzzle(difficulty: .beginner, index: nil); isShowingBeginnerPuzzle = true}){
                    ButtonContent(buttonText: "Beginner")
                }
            }
            NavigationLink(destination: AttemptPuzzleView(), isActive: $isShowingIntermidiatePuzzle){
                Button(action: {chessTacticsManager.getPuzzle(difficulty: .intermidiate, index: nil); isShowingIntermidiatePuzzle = true}){
                    ButtonContent(buttonText: "Intermediate")
                }
            }.padding()
            NavigationLink(destination: AttemptPuzzleView(), isActive: $isShowingAdvancedPuzzle){
                Button(action: {chessTacticsManager.getPuzzle(difficulty: .advanced, index: nil); isShowingAdvancedPuzzle = true}){
                    ButtonContent(buttonText: "Advanced")
                }
            }
            Spacer()
            NavigationLink(destination: UserCreatedPuzzlesView(difficulty: .recent)){
                ButtonContent(buttonText: "Recent Puzzles")
            }.padding()
        }.toolbar{
            ToolbarItem(placement: .principal){
                Text("Puzzles")
            }
        }
    }
}
