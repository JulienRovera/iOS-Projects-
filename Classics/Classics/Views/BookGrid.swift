//
//  BookGrid.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct BookGrid: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View{
        ScrollView(.horizontal){
            LazyHGrid(rows: columns, spacing: 20){
                ForEach(classicsManager.filteredList.indices, id: \.self){ index in
                    let trueIndex = classicsManager.getTrueIndex(index: index)
                    NavigationLink(destination: DetailView(index: trueIndex)){
                        Image(classicsManager.filteredList[index].image)
                            .resizable()
                            .frame(width: 100, height: 120)
                            .padding(.vertical)
                    }
                }
            }
        }.padding(.horizontal)
    }
}
