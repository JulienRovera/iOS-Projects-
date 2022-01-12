//
//  BookGrid.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct MOBookGrid: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    @Environment(\.managedObjectContext) private var viewContext
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var fetchRequest: FetchRequest<BookMO>
    var books: FetchedResults<BookMO> {fetchRequest.wrappedValue}
    
    init(filterPredicate: NSPredicate?){
        fetchRequest = FetchRequest<BookMO>(sortDescriptors: [NSSortDescriptor(keyPath:\BookMO.title, ascending: true)], predicate: filterPredicate, animation: .default)
    }
    var body: some View{
        ScrollView(.horizontal){
            LazyHGrid(rows: columns, spacing: 20){
                ForEach(books){ book in
                    NavigationLink(destination: MODetailView(book: book)){
                        Image(book.image)
                            .resizable()
                            .frame(width: 100, height: 120)
                            .padding(.vertical)
                    }
                }
            }
        }.padding(.horizontal)
    }
}
