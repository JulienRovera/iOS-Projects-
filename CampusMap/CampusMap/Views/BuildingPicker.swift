//
//  BuildingPicker.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/11/21.
//

import Foundation
import SwiftUI
import MapKit

struct BuildingPicker: View{
    @EnvironmentObject var manager: CampusManager
    @Environment(\.presentationMode) var presentationMode
    
    var fromLocation: Bool
    @Binding var directionsLinkIsActive: Bool
    var body: some View{
        Text(fromLocation ? "Get Directions To:" : "Get Directions From:")
        List{
            ForEach(manager.campusModel.buildingList.indices, id: \.self){index in
                Button(action: {getSourceAndDestination(fromCurrentLocation: fromLocation, buildingIndex: index)}){
                    Text(manager.campusModel.buildingList[index].name)
                }
            }
        }
    }
    
    func getSourceAndDestination(fromCurrentLocation: Bool, buildingIndex: Int){
        //let currentLocationItem = MKMapItem.forCurrentLocation()
        let currentLocationItem = manager.locationManager.location
        let buildingCoord = CLLocationCoordinate2D(latitude: manager.campusModel.buildingList[buildingIndex].latitude, longitude: manager.campusModel.buildingList[buildingIndex].longitude)
        let buildingPlacemark = MKPlacemark(coordinate: buildingCoord)
        let buildingMapItem = MKMapItem(placemark: buildingPlacemark)
        let currentLocationPlacemark = MKPlacemark(coordinate: currentLocationItem!.coordinate)
        let currentLocationMapItem = MKMapItem(placemark: currentLocationPlacemark)
        manager.campusModel.buildingList[buildingIndex].gettingDirections = true
        manager.unPlotBuildings()
        manager.plotBuilding(index: buildingIndex)
        manager.campusModel.buildingList[buildingIndex].gettingDirections = false
        if(fromCurrentLocation){
            manager.getDirections(to: buildingMapItem, from: currentLocationMapItem)
        }
        else{
            manager.getDirections(to: currentLocationMapItem, from: buildingMapItem)
        }
        
        directionsLinkIsActive = false
    }
}
