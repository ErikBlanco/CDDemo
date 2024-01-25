//
//  AddShoppingListViewModel.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/24/24.
//

import Foundation

protocol AddShoppingListViewModelDelegate: AnyObject { }

class AddShoppingListViewModel: ObservableObject {
    weak var addShoppingListDelegate: AddShoppingListViewModelDelegate?
    private let shoppingListManager = ShoppingListManager()
    
    func createShoppingList(name: String) {
        let shoppingList = ShoppingList(id: UUID(), name: name, products: [])
        shoppingListManager.createShoppingList(shoppingList: shoppingList)
    }
}
