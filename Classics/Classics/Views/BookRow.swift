//
//  BookRow.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct BookRow: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    var index: Int
    var body: some View{
        HStack{
            Image(classicsManager.classicsModel.bookList[index].image)
                .resizable()
                .frame(width: 110, height: 100)
            Spacer()
            Text(classicsManager.classicsModel.bookList[index].title)
        }
    }
}


