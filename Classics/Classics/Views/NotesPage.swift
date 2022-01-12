//
//  NotesPage.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct NotesPage: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    @State var editMode: EditMode = .inactive
    @State var isAdding = false
    @State var isEditing = false
    @State var tryingToDelete = false
    var index: Int
    var body: some View{
        if isAdding{
            if #available(iOS 15.0, *) {
                AddView(isAdding: $isAdding, index: index)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            } else {
                // Fallback on earlier versions
            }
        }
        
        if #available(iOS 15.0, *) {
            List{
                ForEach($classicsManager.notesList){$note in
                    if(note.book == classicsManager.classicsModel.bookList[index].title){
                        let formattedDate = classicsManager.formatter.string(from: note.date)
                        DisclosureGroup("\(formattedDate)\n\nWas on page \(note.progress)"){
                            Text(note.content)
                            Button(action:{isEditing = true}){
                                Text("Edit Note")
                            }
                            if isEditing{
                                EditView(isEditing: $isEditing, note: $note)
                            }
                            Button(action: {tryingToDelete = true}){
                                Text("Delete Note")
                            }.confirmationDialog("Are you sure you want to delete this note?", isPresented: $tryingToDelete){
                                Button("Delete", role: .destructive){classicsManager.deleteNote(note:note)}
                                Button("Cancel", role: .cancel){}
                            }
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
