//
//  Chess_TacticsApp.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/2/21.
//

import SwiftUI

@main
struct Chess_TacticsApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var chessTacticsManager = ChessTacticsManager()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(chessTacticsManager)
        }
        .onChange(of: scenePhase){phase in
            switch phase{
            case .inactive:
                PersistanceManager.shared.saveRecentPuzzles(recentPuzzlesList: chessTacticsManager.model.recentPuzzlesList)
                PersistanceManager.shared.saveUserCreatedPuzzles(userCreatedPuzzlesList: chessTacticsManager.model.userCreatedPuzzles)
            default: break
            }
        }
    }
}
