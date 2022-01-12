//
//  directionsSheet.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/11/21.
//

import Foundation
import SwiftUI

struct DirectionsSheet: View{
    @EnvironmentObject var manager: CampusManager
    @Binding var directionsSheetIsActive: Bool 
    var body: some View{
        List{
            Section(header: Text("Select Directions")){
                /*Button(action: {}){
                    Text("Get Directions From Current Location")
                }*/
                NavigationLink(destination: BuildingPicker(fromLocation: true, directionsLinkIsActive: $directionsSheetIsActive)){
                    Text("Get Directions From Current Location")
                }
                /*Button(action: {}){
                    Text("Get Directions Between Two Buildings")
                }*/
                NavigationLink(destination: DoubleBuildingPicker(directionsLinkIsActive: $directionsSheetIsActive)){
                    Text("Get Directions Between Two Buildings")
                }
                /*Button(action: {}){
                    Text("Get Directions From Building to Current Location")
                }*/
                NavigationLink(destination: BuildingPicker(fromLocation: false, directionsLinkIsActive: $directionsSheetIsActive)){
                    Text("Get Directions From Building to Current Location")
                }
            }
        }
    }
}
