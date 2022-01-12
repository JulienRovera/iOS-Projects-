//
//  CampusModel.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/3/21.
//

import Foundation

struct Coord {
    var latitude: Double
    var longitude: Double
}

struct CampusModel{
    let manager: StorageManager
    var buildingList : [Building]
    let centerCoord = Coord(latitude: 40.7964685139719, longitude: -77.8628317618596)
    var favorites: [Building]
    init(){
        manager = StorageManager()
        buildingList = manager.buildingList
        buildingList.sort{$0.name < $1.name}
        favorites = []
    }
}
