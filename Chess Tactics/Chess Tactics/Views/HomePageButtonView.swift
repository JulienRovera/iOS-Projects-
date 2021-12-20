//
//  HomePageButtonView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/2/21.
//

import Foundation
import SwiftUI

struct HomePageButtonView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    @State var isShowingPlayGameView = false
    @State var isCreatingPuzzle = false
    var body: some View{
        ScrollView{
            VStack{
                NavigationLink(destination: PuzzlesView()){
                    ButtonContent(buttonText: "Play Puzzles")
                }.padding()
                NavigationLink(destination: CreatePuzzleView(), isActive: $isCreatingPuzzle){
                    Button(action: {chessTacticsManager.initializeNewGame(fen: ChessConstants.startingFen, isPuzzle: false); isCreatingPuzzle = true}){
                        ButtonContent(buttonText: "Create Puzzles")
                    }
                }.padding()
                NavigationLink(destination: PlayGameView(), isActive: $isShowingPlayGameView){
                    Button(action: {chessTacticsManager.initializeNewGame(fen: ChessConstants.startingFen, isPuzzle: false); isShowingPlayGameView = true}){
                        ButtonContent(buttonText: "Play Game")
                    }
                }.padding()
            }
        }
    }
}
