import Foundation
import SwiftUI
struct MODetailView: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    @Environment(\.managedObjectContext) private var viewContext
    @State var progressUpdate = ""
    @ObservedObject var book: BookMO
    var body: some View{
        
        ScrollView{
            NavigationLink(destination: MONotesPage(book: book)){
                Text("View Book Notes")
            }
            MOInfoView(book: book)
            
            Text(classicsManager.getPagesRemainingTextMO(book: book))
            
            HStack{
                Spacer()
                TextField("Enter Current Page Number", text: $progressUpdate)
                    .border(Color(UIColor.separator))
                //.disabled(!classicsManager.classicsModel.bookList[index].reading)
                    .padding()
                    .opacity(book.reading ? 1.0 : 0.0)
            }
            Button(action: {classicsManager.updatePageNumberMO(book: book, pageNumber: Int(progressUpdate)!)}){
                Text("Update Page Number")
                    .padding()
                    .background(Color.gray)
                    .clipShape(Capsule())
            }
            .disabled(!checkIfValid(pageNumber: progressUpdate))
        }
    }
    
    func checkIfValid(pageNumber: String) -> Bool{
        if(book.reading == false){
            return false
        }
        if(book.finished){
            return false
        }
        let checkNum = Int(pageNumber)
        if(checkNum != nil)
        {
            if(checkNum! > book.currentPage){
                if(checkNum! <= book.pages){
                    return true
                }
            }
        }else{
            return false
        }
        return false
    }
}

