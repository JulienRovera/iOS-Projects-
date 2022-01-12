//
//  InfoView.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct InfoView: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    var index: Int
    var body: some View{
        Image(classicsManager.classicsModel.bookList[index].image)
            .resizable()
            .frame(width: 200, height: 240)
            .padding()
        Text(classicsManager.classicsModel.bookList[index].title)
            .padding()
        let authorText = "Written By: " + (classicsManager.classicsModel.bookList[index].author ?? "Anonymous")
        Text(authorText)
        let publishedYearText = "Published " + String(year: classicsManager.classicsModel.bookList[index].year) + " in " + classicsManager.classicsModel.bookList[index].country
        Text(publishedYearText)
            .multilineTextAlignment(.center)
            .padding()
        Text("Language: " + classicsManager.classicsModel.bookList[index].language)
        Text("Number of Pages: " + String(classicsManager.classicsModel.bookList[index].pages))
            .padding()
        Text("Link to Book: " + classicsManager.classicsModel.bookList[index].link)
        
        Button(action: {classicsManager.markAsReading(index: index)}){
            Text(classicsManager.classicsModel.bookList[index].reading ? "Stop Reading" : "Begin Reading")
                .padding()
        }
        .disabled(classicsManager.classicsModel.bookList[index].finished)
    }
}
