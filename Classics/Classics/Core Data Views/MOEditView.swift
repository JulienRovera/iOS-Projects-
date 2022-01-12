//
//  EditView.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct MOEditView: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    @Binding var isEditing: Bool
    @State var text : String = ""
    @State var showAlert = false
    @ObservedObject var note: NoteMO
    var body: some View{
        if #available(iOS 15.0, *) {
            TextField("Edit Note", text: $text)
                .onSubmit{
                    if isValid(text: text){
                        note.content = text
                        isEditing = false
                    }else{
                        showAlert = true
                    }
                }
                .textFieldStyle(.roundedBorder)
                .padding(20)
                .alert("Item cannot be empty", isPresented: $showAlert, actions: {})
        } else {
            // Fallback on earlier versions
        }
    }
    func isValid(text:String) -> Bool {
        !text.isEmpty
    }
}
