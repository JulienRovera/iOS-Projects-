//
//  BookMO+CoreDataProperties.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/25/21.
//
//

import Foundation
import CoreData


extension BookMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookMO> {
        return NSFetchRequest<BookMO>(entityName: "BookMO")
    }

    @NSManaged public var author: String?
    @NSManaged public var country: String
    @NSManaged public var currentPage: Int64
    @NSManaged public var finished: Bool
    @NSManaged public var id: UUID
    @NSManaged public var image: String
    @NSManaged public var language: String
    @NSManaged public var link: String
    @NSManaged public var pages: Int64
    @NSManaged public var reading: Bool
    @NSManaged public var title: String
    @NSManaged public var year: Int64
    @NSManaged public var notes: Set<NoteMO>

}

// MARK: Generated accessors for notes
extension BookMO {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: NoteMO)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: NoteMO)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension BookMO : Identifiable {

}
