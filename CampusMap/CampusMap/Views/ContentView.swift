//
//  ContentView.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/3/21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var manager: CampusManager
    @State var isShowingBuildingList = false
    @State var isShowingDirectionsPrompt = false
    @State var userTrackingMode : MapUserTrackingMode = .follow
    @State var directionsLinkActive: Bool = false
    @State var showFullDirections = false
    var body: some View {
        NavigationView{
            ZStack{
                CampusMap(userTrackingMode: $userTrackingMode)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button(action: {manager.centerOnLocation(); userTrackingMode = .follow}){
                                Text("Center")
                            }
                            .disabled(userTrackingMode == .none ? false : true)
                            .opacity(userTrackingMode == .none ? 1.0 : 0.8)
                        }
                        ToolbarItem(placement: .navigationBarTrailing){SearchButton(isShowingBuildingList: $isShowingBuildingList)}
                        titleItem
                        /*ToolbarItemGroup(placement: .bottomBar){
                         DirectionsTabView()
                         }*/
                    }
                VStack{
                    Spacer()
                    /*Button(action:{isShowingDirectionsPrompt = true}){
                     Text("Get Directions")
                     }*/
                    if(manager.showDirections == false)
                    {
                        NavigationLink(destination: DirectionsSheet(directionsSheetIsActive: $directionsLinkActive), isActive: $directionsLinkActive){
                            Text("Get Directions")
                        }
                        .padding()
                    }
                    if(manager.showDirections){
                        Button(action:{showFullDirections = true}){
                            Text("Show ETA and Full Directions")
                        }
                        DirectionsTabView()
                            .frame(height: 100)
                    }
                }
            }
            .sheet(isPresented: $isShowingBuildingList){
                BuildingSearchList(isShowingBuildingList: $isShowingBuildingList)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button(action: {isShowingBuildingList.toggle()}){
                                Text("Done")
                            }
                        }
                    }
            }
            .sheet(isPresented: $showFullDirections){
                FullDirectionsView()
            }
        }
    }
    var titleItem = ToolbarItem(placement: .principal){
        Text("Campus")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CampusManager())
    }
}
