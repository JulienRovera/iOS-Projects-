//
//  String+Integer.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation

extension String{
    init(year: Int){
        if(year > 0){
            self = String(year)
        }
        else{
            let bcYear = String(year * -1) + " BC"
            self = bcYear
        }
    }
}
