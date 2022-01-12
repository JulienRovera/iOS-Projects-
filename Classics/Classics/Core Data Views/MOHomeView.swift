//
//  ContentView.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import SwiftUI

struct MOHomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var classicsManager: ClassicsManager
    
    @AppStorage("isInitial") var isInitial = true
    
    /*@FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:\NoteMO.date, ascending: true)], predicate: nil, animation: .default)
    var notes: FetchedResults<NoteMO>*/
    var body: some View {
        NavigationView{
            switch classicsManager.mainViewState{
            case .rowView:
                List{
                    MOBookRowList(filterPredicate: classicsManager.filterPredicate)
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        BookToggle()
                    }
                    ToolbarItem(placement: .principal){
                        Text("Book List")
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        FilterToggle()
                    }
                }
            case.cardView:
                MOBookGrid(filterPredicate: classicsManager.filterPredicate)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            BookToggle()
                        }
                        ToolbarItem(placement: .principal){
                            Text("Book List")
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            FilterToggle()
                        }
                    }
            }
        }.environmentObject(classicsManager)
            .onAppear{
                if isInitial{
                    initializeLists()
                    isInitial = false
                }
            }
    }
    
    func initializeLists(){
        classicsManager.classicsModel.bookList.forEach{book in
            let newBook = BookMO(context: viewContext)
            newBook.author = book.author
            newBook.country = book.country
            newBook.image = book.image
            newBook.language = book.language
            newBook.link = book.link
            newBook.pages = Int64(book.pages)
            newBook.title = book.title
            newBook.year = Int64(book.year)
            newBook.reading = book.reading
            newBook.finished = book.finished
            newBook.currentPage = Int64(book.currentPage)
            newBook.id = book.id
        }
    }
}


