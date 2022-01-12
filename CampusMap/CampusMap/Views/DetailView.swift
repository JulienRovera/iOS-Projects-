//
//  DetailView.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/4/21.
//

import SwiftUI

struct DetailView: View{
    @EnvironmentObject var manager: CampusManager
    var buildingIndex : Int
    var body: some View{
        ScrollView{
            Text(manager.campusModel.buildingList[buildingIndex].name)
            if(manager.campusModel.buildingList[buildingIndex].photo != nil){
                Image(manager.campusModel.buildingList[buildingIndex].photo!)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            Image(systemName: manager.campusModel.buildingList[buildingIndex].favorite ? "star.fill" : "star")
                .foregroundColor(.red)
            Button(action: {manager.favoriteBuilding(index: buildingIndex)}){
                Text(manager.campusModel.buildingList[buildingIndex].favorite ? "Unfavorite" : "Favorite")
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.gray)
                    .clipShape(Capsule())
            }
        }.padding()
    }
}
