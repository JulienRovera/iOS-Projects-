//
//  FullDirectionsView.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/11/21.
//

import Foundation
import SwiftUI

struct FullDirectionsView: View{
    @EnvironmentObject var manager: CampusManager
    let formatter = DateComponentsFormatter()
    
    init(){
        formatter.unitsStyle = .full
        formatter.includesApproximationPhrase = true
        //formatter.includesTimeRemainingPhrase = true
        formatter.allowedUnits = [.hour, .minute]
    }
    var body: some View{
        Text("Estimated Time Till Arrival:")
            .padding()
        Text(formatter.string(from: manager.route!.expectedTravelTime)!)
        List{
            Section(header: Text("Directions")){
                ForEach(manager.route!.steps, id: \.self){step in
                    Text(step.instructions)
                }
            }
        }
    }
}
