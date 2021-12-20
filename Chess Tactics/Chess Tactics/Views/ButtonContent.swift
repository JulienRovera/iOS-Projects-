//
//  ButtonContent.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/2/21.
//

import Foundation
import SwiftUI

struct ButtonContent: View{
    var buttonText: String
    var buttonColor: Color
    var buttonWidth: CGFloat
    var buttonHeight: CGFloat
    var buttonCornerRadius: CGFloat
    var textFont: CGFloat
    
    init(buttonText: String){
        self.buttonText = buttonText
        buttonColor = ViewConstants.buttonColor
        buttonWidth = 175
        buttonHeight = 75
        buttonCornerRadius = 20
        textFont = 20
    }
    
    init(buttonText: String, buttonWidth: CGFloat, buttonHeight: CGFloat, buttonCornerRadius: CGFloat){
        self.buttonText = buttonText
        buttonColor = ViewConstants.buttonColor
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
        self.buttonCornerRadius = buttonCornerRadius
        textFont = 20
    }
    
    init(buttonText: String, buttonWidth: CGFloat, buttonHeight: CGFloat, buttonCornerRadius: CGFloat, textFont: CGFloat){
        self.buttonText = buttonText
        buttonColor = ViewConstants.buttonColor
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
        self.buttonCornerRadius = buttonCornerRadius
        self.textFont = textFont
    }
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: buttonCornerRadius)
                .foregroundColor(buttonColor)
                .frame(width: buttonWidth, height: buttonHeight)
            Text(buttonText)
                .foregroundColor(.black)
                .font(.system(size: textFont))
        }
    }
}
