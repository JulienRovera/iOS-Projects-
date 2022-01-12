//
//  CampusManager+CLLocation.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/7/21.
//

import Foundation
import CoreLocation

extension CampusManager{
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, . authorizedWhenInUse:
            showsUserLocation = true
            locationManager.startUpdatingLocation()
            userTrackingMode = .follow
        default:
            locationManager.stopUpdatingLocation()
            showsUserLocation = false
            userTrackingMode = .none
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
    }
}
