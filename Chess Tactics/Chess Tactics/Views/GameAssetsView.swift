//
//  GameAssetsView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/17/21.
//

import Foundation
import SwiftUI

struct GameAssetsView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    var includeHintButton: Bool
    var buttonWidth = UIScreen.main.bounds.width / 4.0
    var buttonHeight = UIScreen.main.bounds.width / 8.0
    var buttonCornerRadius = UIScreen.main.bounds.width / 32.0
    var buttonFontSize = UIScreen.main.bounds.width / 16.0
    var body: some View{
        ScrollView{
            if includeHintButton{
                Text(chessTacticsManager.toMove == .white ? "White to move" : "Black to move")
            }
            HStack{
                Button(action: {chessTacticsManager.viewPreviousMove()}){
                    ButtonContent(buttonText: "<", buttonWidth: buttonWidth, buttonHeight: buttonHeight, buttonCornerRadius: buttonCornerRadius, textFont: buttonFontSize)
                }.padding(.horizontal)
                    .disabled(chessTacticsManager.game.viewedHalfMove < 0 || chessTacticsManager.promotingPiece || chessTacticsManager.puzzleButtonDisabled)
                    .opacity((chessTacticsManager.game.viewedHalfMove < 0 || chessTacticsManager.promotingPiece || chessTacticsManager.puzzleButtonDisabled) ? 0.5 : 1)
                if includeHintButton{
                    Button(action:{chessTacticsManager.puzzleButtonPushed()}){
                        ButtonContent(buttonText: chessTacticsManager.puzzleButtonText, buttonWidth: buttonWidth, buttonHeight: buttonHeight, buttonCornerRadius: buttonCornerRadius)
                    }
                    .disabled(chessTacticsManager.puzzleButtonDisabled || chessTacticsManager.puzzleButtonSuperDisabled)
                    .opacity((chessTacticsManager.puzzleButtonDisabled || chessTacticsManager.puzzleButtonSuperDisabled) ? 0.5: 1.0)
                }
                else{
                    Spacer()
                }
                Button(action: {chessTacticsManager.viewNextMove()}){
                    ButtonContent(buttonText: ">", buttonWidth: buttonWidth, buttonHeight: buttonHeight, buttonCornerRadius: buttonCornerRadius, textFont: buttonFontSize)
                }.padding(.horizontal)
                    .disabled(chessTacticsManager.game.viewedHalfMove >= chessTacticsManager.game.numHalfMoves - 1 || chessTacticsManager.promotingPiece || chessTacticsManager.puzzleButtonDisabled)
                    .opacity((chessTacticsManager.game.viewedHalfMove >= chessTacticsManager.game.numHalfMoves - 1 || chessTacticsManager.promotingPiece || chessTacticsManager.puzzleButtonDisabled) ? 0.5 : 1)
            }
            ZStack{
                ChessBoardView().disabled(chessTacticsManager.disableBoard)
                if chessTacticsManager.promotingPiece{
                    PromotionView(currentTurn: chessTacticsManager.game.currentTurn)
                }
            }
            MoveHistoryView()
        }
    }
}
