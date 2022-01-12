//
//  BuildingRow.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/4/21.
//

import SwiftUI
/*Need to pass in an index of the building and then use that to add the proper builidng
 to the plotted list and also toggle the plotted property of the building itself
 Do this in a function in the view model then pass that into the button action field*/

struct BuildingRow: View{
    @EnvironmentObject var manager: CampusManager
    var buildingIndex: Int
    var body: some View{
        HStack{
            Text(manager.campusModel.buildingList[buildingIndex].name)
            Spacer()
            Button(action: {manager.plotBuilding(index: buildingIndex)}){
                Text(manager.campusModel.buildingList[buildingIndex].plotted ? "Unplot" : "Plot")
            }
            Text("✔️")
               .opacity(manager.campusModel.buildingList[buildingIndex].plotted ? 1.0 : 0)
        }
    }
}
