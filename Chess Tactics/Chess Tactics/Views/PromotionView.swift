//
//  PromotionView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/15/21.
//

import Foundation
import SwiftUI

struct PromotionView: View{
    var imageArray: [String]
    var rectWidth = UIScreen.main.bounds.width / 2.5
    var rectRadius = UIScreen.main.bounds.width / 24.0
    init(currentTurn: pieceColor){
        if currentTurn == .white{
            imageArray = ViewConstants.whitePromotionPieces
        }
        else{
            imageArray = ViewConstants.blackPromotionPieces
        }
    }
    var body: some View{
    
        ZStack{
            RoundedRectangle(cornerRadius: rectRadius)
                .foregroundColor(.white)
                .frame(width: rectWidth, height: rectWidth)
            VStack(spacing: 5){
                HStack(spacing: 5){
                    PromotionViewButton(imageName: imageArray[0], pieceType: pieceType.knight)
                    PromotionViewButton(imageName: imageArray[1], pieceType: pieceType.bishop)
                }
                HStack(spacing: 5){
                    PromotionViewButton(imageName: imageArray[2], pieceType: pieceType.rook)
                    PromotionViewButton(imageName: imageArray[3], pieceType: pieceType.queen)
                }
            }
        }
    }
}
