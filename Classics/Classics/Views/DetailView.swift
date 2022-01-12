//
//  DetailView.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI
struct DetailView: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    @State var progressUpdate = ""
    var index: Int
    var body: some View{
        
        ScrollView{
            NavigationLink(destination: NotesPage(index: index)){
                Text("View Book Notes")
            }
            InfoView(index: index)
            
            Text(classicsManager.getPagesRemainingText(index: index))
            
            HStack{
                Spacer()
                TextField("Enter Current Page Number", text: $progressUpdate)
                    .border(Color(UIColor.separator))
                    //.disabled(!classicsManager.classicsModel.bookList[index].reading)
                    .padding()
                    .opacity(classicsManager.classicsModel.bookList[index].reading ? 1.0 : 0.0)
            }
            Button(action: {classicsManager.updatePageNumber(index: index, pageNumber: Int(progressUpdate)!)}){
                Text("Update Page Number")
                    .padding()
                    .background(Color.gray)
                    .clipShape(Capsule())
            }
            .disabled(!checkIfValid(pageNumber: progressUpdate))
        }
    }
    
    func checkIfValid(pageNumber: String) -> Bool{
        if(classicsManager.classicsModel.bookList[index].reading == false){
            return false
        }
        if(classicsManager.classicsModel.bookList[index].finished){
            return false
        }
        let checkNum = Int(pageNumber)
        if(checkNum != nil)
        {
            if(checkNum! > classicsManager.classicsModel.bookList[index].currentPage){
                if(checkNum! <= classicsManager.classicsModel.bookList[index].pages){
                    return true
                }
            }
        }else{
            print(pageNumber)
            return false
        }
        return false
    }
}

