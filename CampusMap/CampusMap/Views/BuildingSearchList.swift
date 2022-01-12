//
//  BuildingSearchButton.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/3/21.
//

import SwiftUI

struct BuildingSearchList: View{
    @EnvironmentObject var manager : CampusManager
    @Binding var isShowingBuildingList: Bool
    var body: some View{
        
        List{
            Section{
                Button(action: {isShowingBuildingList.toggle()}){
                    Text("Done")
                }
            }
            Section{
                Button(action:{manager.unPlotBuildings()}){
                    Text("None")
                        .foregroundColor(.black)
                }
                Button(action:{manager.plotAllFavorites()}){
                    Text("Plot All Favorites")
                        .foregroundColor(.black)
                }
                ForEach(manager.campusModel.buildingList.indices, id: \.self){index in
                    BuildingRow(buildingIndex: index)
                }
            }
        }
    }
}
