//
//  CampusMap.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/3/21.
//

import SwiftUI
import MapKit

struct CampusMap: View{
    @EnvironmentObject var manager : CampusManager
    @GestureState var press = false
    @State var showingBuilding = false
    @State var building: Building?
    @State var isShowingDetailPage = false
    @Binding var userTrackingMode: MapUserTrackingMode
    var buildingIndex = 0
    var body: some View{
        if #available(iOS 15.0, *) {
            Map(coordinateRegion: $manager.region, interactionModes: .all, showsUserLocation: manager.showsUserLocation, userTrackingMode: $userTrackingMode, annotationItems: manager.plottedBuildings, annotationContent: annotationFor(building:))
                .confirmationDialog("Title",
                                    isPresented: $showingBuilding,
                                    presenting: building,
                                    actions:{ theBuilding in
                    Button("See Building Details"){isShowingDetailPage = true}
                    
                }, message:{ building in
                    Text(building.name)
                })
            .sheet(isPresented: $isShowingDetailPage){
                let index = manager.getBuildingIndex(building: building)
                DetailView(buildingIndex: index)
            }
        } else {
                // Fallback on earlier versions
        }
    }
}
