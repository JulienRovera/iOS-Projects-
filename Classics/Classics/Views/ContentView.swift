//
//  ContentView.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var classicsManager: ClassicsManager
    var body: some View {
        NavigationView{
            switch classicsManager.mainViewState{
            case .rowView:
                List{
                    BookRowList()
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
                BookGrid()
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
