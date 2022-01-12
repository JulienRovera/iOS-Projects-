//
//  BookToggle.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct BookToggle: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    var body: some View{
        Picker("View State", selection: $classicsManager.mainViewState){
            Text("Row View").tag(ClassicsManager.MainViewState.rowView)
            Text("Card View").tag(ClassicsManager.MainViewState.cardView)
            
        }
    }
}
