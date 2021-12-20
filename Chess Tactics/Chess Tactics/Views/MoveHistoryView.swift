//
//  MoveHistoryView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/9/21.
//

import Foundation
import SwiftUI

struct MoveHistoryView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    var body: some View{
        ZStack(alignment: .topLeading){
            /*Rectangle()
             .fill(ViewConstants.buttonColor)
             .frame(width: 312, height: 300)*/
            //ViewConstants.buttonColor
            MoveHistory()
        }
    }
    
    func getMoveText() -> String{
        var moveText = ""
        for move in chessTacticsManager.game.moveList{
            moveText += "\(move.notation) "
        }
        return moveText
    }
}

struct MoveHistory: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    
    var body: some View{
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View{
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading){
            //ViewConstants.buttonColor
            ForEach(chessTacticsManager.game.moveList, id: \.self){ move in
                MoveTextView(move: move)
                    .padding(5)
                    .alignmentGuide(HorizontalAlignment.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if move == chessTacticsManager.game.moveList.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(VerticalAlignment.top, computeValue: {d in
                        let result = height
                        if move == self.chessTacticsManager.game.moveList.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
}

struct MoveTextView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    var move: FullMove
    /*init(index: Int){
        print("printing index")
        print(index)
        self.index = /Users/jar6430/Documents/475proj/cmpsc-475-fall21-JulienRovera/Chess Tactics/Chess Tactics/Views/ChessBoardView.swiftindex
    }*/
    var body: some View{
        ZStack{
            HStack(spacing: 0){
                Text("\(move.number). ")
                    .font(.system(size: UIScreen.main.bounds.width / 16.0))
                Text("\(move.firstMove.notation)")
                    .font(.system(size: UIScreen.main.bounds.width / 16.0))
                    .background((move.number - 1) * 2 == chessTacticsManager.game.viewedHalfMove ? ViewConstants.buttonColor : .clear)
                if let secondHalfMove = move.secondMove{
                    Text(" \(secondHalfMove.notation) ")
                        .font(.system(size: UIScreen.main.bounds.width / 16.0))
                        .background(((move.number - 1) * 2) + 1 == chessTacticsManager.game.viewedHalfMove ? ViewConstants.buttonColor : .clear)
                }
            }
        }
    }
}
