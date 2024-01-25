//
//  ProductDataRepository.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//

import CoreData
import Foundation


protocol ProductRepository {
    func create(product: Product, shoppingListId: UUID)
    func getAll(byShoppingId id: UUID) -> [Product]?
}

class ProductDataRepository: ProductRepository {
    func create(product: Product, shoppingListId: UUID) {
        let cdProduct = CDProduct(context: PersistentStorage.shared.context)
        cdProduct.id = product.id
        cdProduct.name = product.name
        cdProduct.price = product.price
        
        let shoppingListDataRepository = ShoppingListDataRepository()
        let cdShoppingList = shoppingListDataRepository.getCDShoppingList(byIdentifier: shoppingListId)
        cdShoppingList?.addToProduct(cdProduct)
        // Line below also works, instead of calling addToProduct
        // cdProduct.shoppingList = cdShoppingList
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll(byShoppingId id: UUID) -> [Product]? {
        let shoppingListDataRepository = ShoppingListDataRepository()
        let cdShoppingList = shoppingListDataRepository.getCDShoppingList(byIdentifier: id)
        
        return cdShoppingList?.convertToShoppingList().products
    }
}
