//
//  Book.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/18/21.
//

import Foundation

struct Book: Codable, Equatable{
    var author: String?
    var country: String
    var image: String
    var language: String
    var link: String
    var pages: Int
    var title: String
    var year: Int
    var reading: Bool
    var finished: Bool
    var currentPage: Int
    var id = UUID()
    static let standard = Book(author: "Chinua Achebe", country: "Nigeria", image: "things-fall-apart", language: "English", link: "https://en.wikipedia.org/wiki/Things_Fall_Apart", pages: 209, title: "Things Fall Apart", year: 1958, reading: false, finished: false, currentPage: 0)
}

extension Book{
    enum CodingKeys: CodingKey{
        case author
        case country
        case image
        case language
        case link
        case pages
        case title
        case year
        case reading
        case finished
        case currentPage
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do{
            author = try values.decode(String.self, forKey: .author)
        }catch{
            author = nil
        }
        country = try values.decode(String.self, forKey: .country)
        image = try values.decode(String.self, forKey: .image)
        language = try values.decode(String.self, forKey: .language)
        link = try values.decode(String.self, forKey: .link)
        pages = try values.decode(Int.self, forKey: .pages)
        title = try values.decode(String.self, forKey: .title)
        year = try values.decode(Int.self, forKey: .year)
        do{
            reading = try values.decode(Bool.self, forKey: .reading)
        }catch{
            reading = false
        }
        do{
            finished = try values.decode(Bool.self, forKey: .finished)
        }catch{
            finished = false
        }
        do{
            currentPage = try values.decode(Int.self, forKey: .currentPage)
        }catch{
            currentPage = 0
        }
    }
}

extension Book{
    static func == (lhs: Book, rhs: Book) -> Bool{
        return lhs.title == rhs.title
    }
}
