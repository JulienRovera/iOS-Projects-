//
//  ChessSquareView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/9/21.
//

import Foundation
import SwiftUI

struct ChessSquareView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    var square: ChessSquare
    var squareLength: CGFloat
    var circleSize: CGFloat
    init(square: ChessSquare){
        if UIDevice.current.userInterfaceIdiom == .pad{
            squareLength = (UIScreen.main.bounds.width / 10.0) - 1
            circleSize = (UIScreen.main.bounds.width / 10.0) - (UIScreen.main.bounds.width / 20.0)
        }
        else{
            squareLength = (UIScreen.main.bounds.width / 8.0) - 1
            circleSize = (UIScreen.main.bounds.width / 8.0) - (UIScreen.main.bounds.width / 16.0)
        }
        self.square = square
    }
    var squareColor: Color{
        if square.number == chessTacticsManager.game.selectedSquare?.number || square.number == chessTacticsManager.game.previousDepartureSquare?.number || square.number == chessTacticsManager.game.previousDestinationSquare?.number{
            return (square.color == .dark ? ViewConstants.darkSquareSelectedColor : ViewConstants.lightSquareSelectedColor)
        }
        return (square.color == .dark ?  ViewConstants.darkSquareColor :  ViewConstants.lightSquareColor)
    }
    var body: some View{
        let tapPieceGesture = TapGesture()
            .onEnded{
                if square.legalSquare{
                    chessTacticsManager.squareTapped(square: square)
                    return
                }
                if square.piece!.color == chessTacticsManager.game.currentTurn{
                    chessTacticsManager.findLegalMoves(square: square)
                }
            }
        let tapSquareGesture = TapGesture()
            .onEnded{
                chessTacticsManager.squareTapped(square: square)
            }
        ZStack{
            Rectangle()
                .fill(squareColor)
                .frame(width: squareLength, height: squareLength)
                .gesture(tapSquareGesture)
            if(square.piece != nil){
                Image(square.piece!.imageName)
                    .resizable()
                    .frame(width: squareLength, height: squareLength)
                    .gesture(tapPieceGesture)
            }
            if(square.legalSquare){
                Circle()
                    .fill(.black)
                    .frame(width: circleSize, height: circleSize)
                    .opacity(0.4)
            }
        }
    }
}
