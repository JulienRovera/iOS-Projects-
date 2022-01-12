//
//  CampusManager.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/3/21.
//

import Foundation
import MapKit

class CampusManager : NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var campusModel : CampusModel
    @Published var region: MKCoordinateRegion
    
    //will need to change later to reflect privacy regulations
    @Published var showsUserLocation = false
    @Published var plottedBuildings : [Building] = []
    @Published var route: MKRoute?
    @Published var showDirections = false
    let locationManager : CLLocationManager
    var userTrackingMode: MKUserTrackingMode = .none
    
    let spanDelta = 0.01
    
    override init(){
        let campusModel = CampusModel()
        let center : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: campusModel.centerCoord.latitude, longitude: campusModel.centerCoord.longitude)
        let span = MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta)
        region = MKCoordinateRegion(center: center, span: span)
        self.campusModel = campusModel
        
        locationManager = CLLocationManager()
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        
        initLists()
    }
    
    func plotBuilding(index: Int){
        let buildingIndex = plottedBuildings.firstIndex(of: campusModel.buildingList[index])
        if(buildingIndex != nil){
            campusModel.buildingList[index].plotted = false
            plottedBuildings.remove(at: buildingIndex!)
            updateRegion()
            return
        }
        campusModel.buildingList[index].plotted = true
        plottedBuildings.append(campusModel.buildingList[index])
        updateRegion()
    }
    
    func favoriteBuilding(index: Int){
        let buildingIndex = campusModel.favorites.firstIndex(of: campusModel.buildingList[index])
        if(buildingIndex != nil){
            campusModel.buildingList[index].favorite = false
            campusModel.favorites.remove(at: buildingIndex!)
        }else{
            campusModel.buildingList[index].favorite = true
            campusModel.favorites.append(campusModel.buildingList[index])
        }
        plotBuilding(index: index)
        plotBuilding(index: index)
    }
    
    func unPlotBuildings(){
        plottedBuildings.removeAll()
        for index in campusModel.buildingList.indices {
            campusModel.buildingList[index].plotted = false
        }
        updateRegion()
    }
    
    func getBuildingIndex(building: Building?) -> Int{
        let buildingIndex = campusModel.buildingList.firstIndex(of: building!)
        return buildingIndex!
    }
    
    func plotAllFavorites(){
        for index in campusModel.favorites.indices{
            if(plottedBuildings.firstIndex(of: campusModel.favorites[index]) == nil){
                plotBuilding(index: campusModel.buildingList.firstIndex(of: campusModel.favorites[index])!)
            }
        }
    }
    
    func initLists(){
        for index in campusModel.buildingList.indices{
            if(campusModel.buildingList[index].plotted){
                plotBuilding(index: index)
                //plottedBuildings.append(campusModel.buildingList[index])
            }
            if(campusModel.buildingList[index].favorite){
                campusModel.favorites.append(campusModel.buildingList[index])
            }
        }
    }
    
    func centerOnLocation(){
        region.center = CLLocationCoordinate2D(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude)
    }
    
    func getDirections(to destination: MKMapItem, from source: MKMapItem){
        let request = MKDirections.Request()
        request.source = source
        request.destination = destination
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        let directions = MKDirections(request: request)
        
        directions.calculate {response, error in
            guard (error == nil) else {return}
            
            self.route = response!.routes.first
            self.showDirections = true
        }
    }
    func updateRegion(){
        let currentLocationItem = locationManager.location
        var maxLat = 0.0
        var maxLon = 0.0
        var minLat = 0.0
        var minLon = 0.0
        if(plottedBuildings.count > 0)
        {
            maxLat = plottedBuildings[0].latitude
            maxLon = plottedBuildings[0].longitude
            minLat = plottedBuildings[0].latitude
            minLon = plottedBuildings[0].longitude
        }
        else{
            if(currentLocationItem == nil){
                return
            }
        }
        if(currentLocationItem != nil){
            let currentLocationCoord = currentLocationItem!.coordinate
             maxLat = currentLocationCoord.latitude
             maxLon = currentLocationCoord.longitude
             minLat = currentLocationCoord.latitude
             minLon = currentLocationCoord.longitude
        }
        for building in plottedBuildings{
            if(building.latitude > maxLat){
                maxLat = building.latitude
            }
            if(building.longitude < maxLon){
                maxLon = building.longitude
            }
            if(building.latitude < minLat){
                minLat = building.latitude
            }
            if(building.longitude > minLon){
                minLon = building.longitude
            }
        }
        let newCenterLat = (maxLat+minLat)/2
        let newCenterLon = (maxLon+minLon)/2
        //print(currentLocationCoord)
        let newSpan = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) + 0.005, longitudeDelta: -(maxLon - minLon) + 0.005)
        let newCenter = CLLocationCoordinate2D(latitude: newCenterLat, longitude: newCenterLon)
        region.span = newSpan
        region.center = newCenter
        /*let test1 = CLLocation(latitude: 0, longitude: 0)
        let test2 = CLLocation(latitude: 100, longitude: 100)
        let distanceInMeters = test1.distance(from: test2)*/
    }
    
    func cancelDirections(){
        showDirections = false
        for index in campusModel.buildingList.indices{
            if(campusModel.buildingList[index].plotted){
                plotBuilding(index: index)
                plotBuilding(index: index)
            }
        }
    }
}
