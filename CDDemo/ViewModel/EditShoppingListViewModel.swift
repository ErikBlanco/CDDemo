//
//  EditShoppingListViewModel.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//

import Foundation

protocol EditShoppingListViewModelDelegate: AnyObject {
    
}

class EditShoppingListViewModel: ObservableObject {
    weak var editShoppingListViewModelDelegate: EditShoppingListViewModelDelegate?
    private var shoppingListManager = ShoppingListManager()
    
    func updateShoppingList(shoppingList: ShoppingList, name: String) -> Bool {
        shoppingListManager.updateShoppingList(shoppingList: ShoppingList(id: shoppingList.id, name: name, products: shoppingList.products))
    }
}
