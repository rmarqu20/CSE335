//
//  CIty+CoreDataProperties.swift
//  Lab4
//
//  Created by Richard Marquez on 3/15/22.
//
//

import Foundation
import CoreData

extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var cityDescription: String?
    @NSManaged public var cityImage: NSData?
}

extension City : Identifiable {

}
