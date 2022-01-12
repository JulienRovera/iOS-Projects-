//
//  NotesPage.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct MONotesPage: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    @Environment(\.managedObjectContext) private var viewContext
    @State var editMode: EditMode = .inactive
    @State var isAdding = false
    @State var isEditing = false
    @State var tryingToDelete = false
    @ObservedObject var book: BookMO
    var body: some View{
        if isAdding{
            if #available(iOS 15.0, *) {
                MOAddView(isAdding: $isAdding, book: book)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            } else {
                // Fallback on earlier versions
            }
        }
        
        if #available(iOS 15.0, *) {
            List{
                ForEach(Array(book.notes)){note in
                    let formattedDate = classicsManager.formatter.string(from: note.date)
                    DisclosureGroup("\(formattedDate)\n\nWas on page \(note.progress)"){
                        Text(note.content)
                        Button(action:{isEditing = true}){
                            Text("Edit Note")
                        }
                        if isEditing{
                            MOEditView(isEditing: $isEditing, note: note)
                        }
                        Button(action: {tryingToDelete = true}){
                            Text("Delete Note")
                        }.confirmationDialog("Are you sure you want to delete this note?", isPresented: $tryingToDelete){
                            Button("Delete", role: .destructive){book.removeFromNotes(note)}
                            Button("Cancel", role: .cancel){}
                            
                        }
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    Button(action:{isAdding.toggle()}){
                        Image(systemName: "plus.square")
                    }
                }
            }
            
        } else {
            // Fallback on earlier versions
        }
    }
}
