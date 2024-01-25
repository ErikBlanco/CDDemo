//
//  CDProduct+CoreDataProperties.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//
//

import Foundation
import CoreData


extension CDProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProduct> {
        return NSFetchRequest<CDProduct>(entityName: "CDProduct")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var price: Float
    @NSManaged public var shoppingList: CDShoppingList?
    
    public var unwrappedName: String {
        name ?? "Unknown name"
    }
}

extension CDProduct : Identifiable {

}
