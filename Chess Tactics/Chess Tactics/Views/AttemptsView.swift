//
//  AttemptsView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/18/21.
//

import Foundation
import SwiftUI

struct AttemptsView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    var body: some View{
        HStack{
            Text("Attempts:")
            ForEach(chessTacticsManager.puzzleAttempts.indices, id: \.self){index in
                switch chessTacticsManager.puzzleAttempts[index]{
                case .unfinished: Text("__")
                case .correct: Text("✔️")
                case .incorrect: Text("✖️")
                }
            }
        }
    }
}
