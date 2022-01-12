//
//  Building.swift
//  CampusMap
//
//  Created by Rovera, Julien Anthony on 10/3/21.
//

import Foundation

struct Building: Codable, Identifiable, Equatable{
    var latitude: Double
    var longitude: Double
    var name: String
    var opp_bldg_code: Int
    var year_constructed: Int?
    var photo: String?
    var plotted: Bool
    var favorite: Bool
    var gettingDirections: Bool
    var id: Int
    static let standard = Building(latitude: 40.8017390346291, longitude: -77.8543146925926, name: "Curry Hall", opp_bldg_code: 270002, year_constructed: 2004, photo: nil, plotted: false, favorite: false, gettingDirections: false, id: 270002)
}

extension Building{
    enum CodingKeys: CodingKey{
        case latitude
        case longitude
        case name
        case opp_bldg_code
        case year_constructed
        case photo
        case plotted
        case favorite
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        name = try values.decode(String.self, forKey: .name)
        opp_bldg_code = try values.decode(Int.self, forKey: .opp_bldg_code)
        id = opp_bldg_code
        do{
            year_constructed = try values.decode(Int.self, forKey: .year_constructed)
        }catch{
            year_constructed = nil
        }
        do{
            photo = try values.decode(String.self, forKey: .photo)
        }catch{
            photo = nil
        }
        do{
            plotted = try values.decode(Bool.self, forKey: .plotted)
        }catch{
            plotted = false
        }
        do{
            favorite = try values.decode(Bool.self, forKey: .favorite)
        }catch{
            favorite = false
        }
        gettingDirections = false
    }
}

extension Building{
    static func == (lhs: Building, rhs: Building)-> Bool{
        return lhs.id == rhs.id
    }
}

