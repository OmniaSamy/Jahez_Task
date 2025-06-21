//
//  CDMovie+CoreDataProperties.swift
//  
//
//  Created by Omnia Samy on 21/06/2025.
//
//

import Foundation
import CoreData


extension CDMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged public var genreIds: NSObject?
    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?

}
