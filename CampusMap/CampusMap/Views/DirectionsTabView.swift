//
//  DirectionsTabView.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/11/21.
//

import Foundation
import SwiftUI

struct DirectionsTabView: View{
    @EnvironmentObject var manager: CampusManager
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .opacity(0.5)
            VStack{
                TabView{
                    ForEach(manager.route!.steps, id: \.self){step in
                        HStack{
                            Text("<")
                                .foregroundColor(.gray)
                            Text(step.instructions)
                                .tabItem{
                                    Text("1")
                                }
                            Text(">")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .tabViewStyle(.page)
                Button(action: {manager.cancelDirections()}){
                    Text("Cancel Directions")
                }
            }
        }
    }
}
