//
//  CDShoppingList+CoreDataProperties.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//
//

import Foundation
import CoreData


extension CDShoppingList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDShoppingList> {
        return NSFetchRequest<CDShoppingList>(entityName: "CDShoppingList")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var product: NSSet?
    
    public var unwrappedName: String {
        name ?? "Unknown name"
    }

    public var cdProductArray: [CDProduct] {
        let set = product as? Set<CDProduct> ?? []
        
        return set.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
    }
}

// MARK: Generated accessors for product
extension CDShoppingList {

    @objc(addProductObject:)
    @NSManaged public func addToProduct(_ value: CDProduct)

    @objc(removeProductObject:)
    @NSManaged public func removeFromProduct(_ value: CDProduct)

    @objc(addProduct:)
    @NSManaged public func addToProduct(_ values: NSSet)

    @objc(removeProduct:)
    @NSManaged public func removeFromProduct(_ values: NSSet)

}

extension CDShoppingList : Identifiable {

}
