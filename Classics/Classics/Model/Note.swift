//
//  Note.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation

struct Note: Codable, Hashable, Identifiable{
    var progress: Int
    var date: Date
    var content: String
    var book: String
    var id = UUID()
}

extension Note{
    enum CodingKeys: CodingKey{
        case progress
        case date
        case content
        case book
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        progress = try values.decode(Int.self, forKey: .progress)
        date = try values.decode(Date.self, forKey: .date)
        content = try values.decode(String.self, forKey: .content)
        book = try values.decode(String.self, forKey: .book)
    }
}
