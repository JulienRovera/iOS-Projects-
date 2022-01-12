//
//  ClassicsApp.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import SwiftUI

@main
struct ClassicsApp: App {
    
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var classicsManager = ClassicsManager()
    var body: some Scene {
        WindowGroup {
            MOHomeView()
                .environmentObject(classicsManager)
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase){phase in
            switch phase{
            case .inactive:
                PersistanceManager.shared.saveNotes(noteList: classicsManager.notesList)
                PersistanceManager.shared.saveBookList(bookList: classicsManager.classicsModel.bookList)
                try? persistenceController.container.viewContext.save()
            default:
                break
            }
        }
    }
}
