//
//  Map+Annotation.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/3/21.
//

import SwiftUI
import MapKit

extension CampusMap{
    func annotationFor(building: Building) -> some MapAnnotationProtocol{
        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)){
            /*
            Button(action: {showingBuilding = true; self.building = building}){
                Image(systemName: "mappin.circle")
                    .scaleEffect(1.5)
            }
             */
            Image(systemName: building.gettingDirections ? "flag.circle" : "mappin.circle")
                .scaleEffect(1.5)
                .foregroundColor(building.favorite ? .red : .black)
                .gesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .updating($press){currentState, gestureState, transaction in gestureState = currentState}
                        .onEnded{value in showingBuilding = true; self.building = building})
        }
    }
}
