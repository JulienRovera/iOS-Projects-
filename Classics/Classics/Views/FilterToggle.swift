//
//  FilterToggle.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation
import SwiftUI

struct FilterToggle: View{
    @EnvironmentObject var classicsManager: ClassicsManager
    
    var body: some View{
        Picker("Filter", selection: $classicsManager.bookFilter){
            Text("All Books").tag(ClassicsManager.BookFilter.all)
            Text("Currently Reading").tag(ClassicsManager.BookFilter.reading)
            Text("Finished Books").tag(ClassicsManager.BookFilter.finished)
        }
    }
}
