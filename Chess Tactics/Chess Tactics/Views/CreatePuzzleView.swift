//
//  CreatePuzzleView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 12/6/21.
//

import SwiftUI

struct CreatePuzzleView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    @State var showTextField: Bool = false
    @State var puzzleName: String = ""
    var recordButtonWidth = UIScreen.main.bounds.width / 3.0
    var recordButtonHeight = UIScreen.main.bounds.width / 7.0
    var recordButtonRadius = UIScreen.main.bounds.width / 32.0
    var body: some View{
        ZStack{
            ScrollView{
                VStack{
                    if chessTacticsManager.game.isRecording{
                        RecordingButtonsView(showTextField: $showTextField)
                    }
                    else{
                        Button(action: {chessTacticsManager.beginRecording()}){
                            ButtonContent(buttonText: "Record", buttonWidth: recordButtonWidth, buttonHeight: recordButtonHeight, buttonCornerRadius: recordButtonRadius)
                        }
                    }
                    GameAssetsView(includeHintButton: false)
                        
                }.disabled(chessTacticsManager.disableCreatePuzzlesView)
                    .opacity(chessTacticsManager.disableCreatePuzzlesView ? 0.5: 1.0)
            }
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Create Puzzle")
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: UserCreatedPuzzlesView(difficulty: .userCreated)){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(ViewConstants.buttonColor)
                    }
                }
            }.disabled(chessTacticsManager.disableCreatePuzzlesView)
            if showTextField{
                enterNameView(showEntryNameView: $showTextField)
                    .transition(.move(edge: .bottom))
            }
        }.onAppear{
            chessTacticsManager.initializeNewGame(fen: ChessConstants.startingFen, isPuzzle: false)
        }
    }

}

struct RecordingButtonsView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    @Binding var showTextField: Bool
    var recordButtonWidth = UIScreen.main.bounds.width / 3.5
    var recordButtonHeight = UIScreen.main.bounds.width / 7.0
    var recordButtonRadius = UIScreen.main.bounds.width / 32.0
    var body: some View{
        HStack{
            Button(action:{chessTacticsManager.cancelRecording()}){
                ButtonContent(buttonText: "Cancel", buttonWidth: recordButtonWidth, buttonHeight: recordButtonHeight, buttonCornerRadius: recordButtonRadius)
            }
            Button(action:{withAnimation{showTextField = true}; chessTacticsManager.disableCreatePuzzlesView = true}){
                ButtonContent(buttonText: "Finish", buttonWidth: recordButtonWidth, buttonHeight: recordButtonHeight, buttonCornerRadius: recordButtonRadius)
            }.disabled(chessTacticsManager.game.moveList.count <= 0)
                .opacity(chessTacticsManager.game.moveList.count <= 0 ? 0.5 : 1)
        }
    }
}

struct enterNameView: View{
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    @State var puzzleName: String = ""
    @Binding var showEntryNameView: Bool
    let screenSize = UIScreen.main.bounds
    var body: some View{
        VStack(alignment: .center){
            Text("Name your puzzle. To view, press the magnifying glass")
            TextField("", text: $puzzleName)
                .textFieldStyle(.roundedBorder)
            HStack{
                Button(action: {showEntryNameView = false; chessTacticsManager.disableCreatePuzzlesView = false}){
                    Text("Cancel")
                        .foregroundColor(.red)
                }
                Divider()
                    .frame(height: 30)
                Button(action: {chessTacticsManager.finishRecording(newPuzzleName: puzzleName); showEntryNameView = false}){
                    Text("Create")
                        .foregroundColor(.black)
                }.disabled(puzzleName == "")
                    .opacity(puzzleName == "" ? 0.5 : 1.0)
            }
        }.padding()
            .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.3)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
            .shadow(radius: 5)
    }
}

/*struct enterNameView_Previews: PreviewProvider{
    static var previews: some View{
        enterNameView()
    }
}*/
