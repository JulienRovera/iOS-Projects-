//
//  AddView.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
struct AddView: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    @Binding var isAdding: Bool
    @State var text : String = ""
    @State var showAlert = false
    var index: Int
    var body: some View{
        TextField("Enter New Note", text: $text)
            .onSubmit{
                if isValid(text: text){
                    classicsManager.createNote(index: index, content: text)
                    isAdding = false
                }else{
                    showAlert = true
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding(20)
            .alert("Item cannot be empty", isPresented: $showAlert, actions: {})
    }
    
    func isValid(text:String) -> Bool {
        !text.isEmpty
    }
}
