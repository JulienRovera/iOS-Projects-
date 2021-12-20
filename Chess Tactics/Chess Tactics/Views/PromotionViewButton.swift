//
//  PromotionViewButton.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/15/21.
//

import Foundation
import SwiftUI

struct PromotionViewButton: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    var imageName: String
    var pieceType: pieceType
    var buttonLength = UIScreen.main.bounds.width / 6.0
    var buttonRadius = UIScreen.main.bounds.width / 32.0
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: buttonRadius)
                .foregroundColor(ViewConstants.buttonColor)
                .frame(width: buttonLength, height: buttonLength)
            Button(action: {chessTacticsManager.promotePiece(newType: pieceType, newImage: imageName)}){
                Image(imageName)
                    .resizable()
                    .frame(width: buttonLength, height: buttonLength)
            }
        }
    }
}
