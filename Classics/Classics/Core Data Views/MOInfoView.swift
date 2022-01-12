//
//  InfoView.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct MOInfoView: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    @ObservedObject var book: BookMO
    var body: some View{
        Image(book.image)
            .resizable()
            .frame(width: 200, height: 240)
            .padding()
        Text(book.title)
            .padding()
        let authorText = "Written By: " + (book.author ?? "Anonymous")
        Text(authorText)
        let publishedYearText = "Published " + String(year: Int(book.year)) + " in " + book.country
        Text(publishedYearText)
            .multilineTextAlignment(.center)
            .padding()
        Text("Language: " + book.language)
        Text("Number of Pages: " + String(book.pages))
            .padding()
        Text("Link to Book: " + book.link)
        
        Button(action: {book.reading.toggle()}){
            Text(book.reading ? "Stop Reading" : "Begin Reading")
                .padding()
        }
        .disabled(book.finished)
    }
}
