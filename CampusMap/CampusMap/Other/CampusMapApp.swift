//
//  CampusMapApp.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/3/21.
//

import SwiftUI

@main
struct CampusMapApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var campusManager = CampusManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(campusManager)
        }
        .onChange(of: scenePhase){phase in
            switch phase{
            case.inactive:
                PersistanceManager.shared.save(buildingList: campusManager.campusModel.buildingList)
            default:
                break
            }
        }
    }
}
