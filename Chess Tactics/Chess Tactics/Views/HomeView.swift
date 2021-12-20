//
//  ContentView.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/2/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var chessTacticsManager: ChessTacticsManager
    var body: some View {
        NavigationView{
            HomePageButtonView()
                .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Chess Tactics")
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
