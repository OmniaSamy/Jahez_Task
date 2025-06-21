//
//  CDGenre+CoreDataProperties.swift
//  
//
//  Created by Omnia Samy on 21/06/2025.
//
//

import Foundation
import CoreData


extension CDGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGenre> {
        return NSFetchRequest<CDGenre>(entityName: "CDGenre")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?

}
