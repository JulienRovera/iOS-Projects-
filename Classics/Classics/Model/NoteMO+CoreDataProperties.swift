//
//  NoteMO+CoreDataProperties.swift
//  Classics
//
//  Created by Rovera, Julien Anthony on 10/25/21.
//
//

import Foundation
import CoreData


extension NoteMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteMO> {
        return NSFetchRequest<NoteMO>(entityName: "NoteMO")
    }

    @NSManaged public var content: String
    @NSManaged public var date: Date
    @NSManaged public var id: UUID
    @NSManaged public var progress: Int64
    @NSManaged public var book: BookMO

}

extension NoteMO : Identifiable {

}
