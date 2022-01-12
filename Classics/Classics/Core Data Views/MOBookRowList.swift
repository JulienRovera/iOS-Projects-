//
//  BookRowList.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct MOBookRowList: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    @Environment(\.managedObjectContext) private var viewContext
    
    //@FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:\BookMO.title, ascending: true)], predicate: nil, animation: .default)
    var fetchRequest: FetchRequest<BookMO>
    var books: FetchedResults<BookMO> {fetchRequest.wrappedValue}
    
    init(filterPredicate: NSPredicate?){
        fetchRequest = FetchRequest<BookMO>(sortDescriptors: [NSSortDescriptor(keyPath:\BookMO.title, ascending: true)], predicate: filterPredicate, animation: .default)
    }
    var body: some View{
        ForEach(books){ book in
            NavigationLink(destination: MODetailView(book: book)){
                MOBookRow(book: book)
            }
        }
    }
}
