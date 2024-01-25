//
//  ShoppingListManager.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//

import Foundation

struct ShoppingListManager {
    private let _shoppingListDataRepository = ShoppingListDataRepository()
    
    func createShoppingList(shoppingList: ShoppingList) {
        _shoppingListDataRepository.create(shoppingList: shoppingList)
    }
    
    func fetchShoppingList() -> [ShoppingList]? {
        return _shoppingListDataRepository.getAllByBatchesOf(5)
    }
    
    func fetchShoppingList(byIdentifier id: UUID) -> ShoppingList? {
        return _shoppingListDataRepository.get(byIdentifier: id)
    }
    
    func updateShoppingList(shoppingList: ShoppingList) -> Bool {
        return _shoppingListDataRepository.update(shoppingList: shoppingList)
    }
    
    func deleteShoppingList(id: UUID) -> Bool {
        return _shoppingListDataRepository.delete(id: id)
    }
}
