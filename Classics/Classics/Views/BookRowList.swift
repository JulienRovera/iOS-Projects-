//
//  BookRowList.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct BookRowList: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    var body: some View{
        ForEach(classicsManager.filteredList.indices, id: \.self){ index in
            let trueIndex = classicsManager.getTrueIndex(index: index)
            NavigationLink(destination: DetailView(index: trueIndex)){
                BookRow(index: trueIndex)
            }
        }
    }
}
