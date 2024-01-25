//
//  ShoppingListViewModel.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/24/24.
//

import CoreData
import Foundation

protocol ShoppingListViewModelDelegate: BaseProtocol {
    func updateUI()
}

class ShoppingListViewModel: ObservableObject {
    weak var shoppingListDelegate: ShoppingListViewModelDelegate?
    private let shoppingListManager = ShoppingListManager()
    
    var shoppingLists: [ShoppingList] = [] {
        didSet {
            refreshTableView()
        }
    }
    
    func refreshTableView() {
        self.shoppingListDelegate?.updateUI()
    }
    
    func fetchShoppingLists() {
        shoppingLists = shoppingListManager.fetchShoppingList() ?? []
    }
    
    func deleteShoppingList(byShoppingListId id: UUID) -> Bool {
        shoppingListManager.deleteShoppingList(id: id)
    }
}
