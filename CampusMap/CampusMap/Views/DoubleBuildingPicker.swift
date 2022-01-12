//
//  DoubleBuildingPicker.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/11/21.
//

import Foundation
import SwiftUI
import MapKit

struct DoubleBuildingPicker: View{
    @EnvironmentObject var manager: CampusManager
    @Binding var directionsLinkIsActive: Bool
    
    var body: some View{
        Text("Get Directions From:")
        List{
            ForEach(manager.campusModel.buildingList.indices, id: \.self){index in
                NavigationLink(destination: SecondBuildingPicker(directionsLinkIsActive: $directionsLinkIsActive, building1Index: index)){
                    Text(manager.campusModel.buildingList[index].name)
                }
            }
        }
    }
}

struct SecondBuildingPicker: View{
    @EnvironmentObject var manager: CampusManager
    @Binding var directionsLinkIsActive: Bool
    var building1Index: Int
    var body: some View{
        Text("Get Directions To:")
        List{
            ForEach(manager.campusModel.buildingList.indices, id: \.self){index in
                if(index != building1Index){
                    Button(action: {getSourceAndDestination(sourceIndex: building1Index, destinationIndex: index)}){
                        Text(manager.campusModel.buildingList[index].name)
                    }
                }
            }
        }
    }
    
    func getSourceAndDestination(sourceIndex: Int, destinationIndex: Int){
        let sourceCoord = CLLocationCoordinate2D(latitude: manager.campusModel.buildingList[sourceIndex].latitude, longitude: manager.campusModel.buildingList[sourceIndex].longitude)
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoord)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationCoord = CLLocationCoordinate2D(latitude: manager.campusModel.buildingList[destinationIndex].latitude, longitude: manager.campusModel.buildingList[destinationIndex].longitude)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoord)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        manager.campusModel.buildingList[sourceIndex].gettingDirections = true
        manager.campusModel.buildingList[destinationIndex].gettingDirections = true
        manager.unPlotBuildings()
        manager.plotBuilding(index: sourceIndex)
        manager.plotBuilding(index: destinationIndex)
        manager.campusModel.buildingList[sourceIndex].gettingDirections = false
        manager.campusModel.buildingList[destinationIndex].gettingDirections = false
        
        manager.getDirections(to: destinationMapItem, from: sourceMapItem)
    }
}
