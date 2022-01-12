//
//  SearchButton.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/3/21.
//

import SwiftUI

struct SearchButton: View{
    @Binding var isShowingBuildingList: Bool
    var body: some View{
        Button(action: {isShowingBuildingList.toggle()}){
            Text("Buildings")
        }
    }
}
