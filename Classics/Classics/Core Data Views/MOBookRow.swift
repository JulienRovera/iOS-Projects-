//
//  BookRow.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct MOBookRow: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    //@Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var book: BookMO
    var body: some View{
        HStack{
            Image(book.image)
                .resizable()
                .frame(width: 110, height: 100)
            Spacer()
            Text(book.title)
        }
    }
}
