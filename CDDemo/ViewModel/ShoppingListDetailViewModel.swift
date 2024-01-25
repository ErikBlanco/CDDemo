//
//  ShoppingListDetailViewModel.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//

import Foundation

protocol ShoppingListDetailViewModelDelegate: AnyObject {
    func updateUI()
}

class ShoppingListDetailViewModel: ObservableObject {
    weak var shoppingListDetailViewModelDelegate: ShoppingListDetailViewModelDelegate?
    private let shoppingListManager = ShoppingListManager()
    var shoppingList: ShoppingList {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        self.shoppingListDetailViewModelDelegate?.updateUI()
    }
    
    func fetchShoppingList() {
        shoppingList = shoppingListManager.fetchShoppingList(byIdentifier: shoppingList.id) ?? shoppingList
    }
    
    init(shoppingListDetailViewModelDelegate: ShoppingListDetailViewModelDelegate, selectedShoppingList: ShoppingList) {
        self.shoppingListDetailViewModelDelegate = shoppingListDetailViewModelDelegate
        self.shoppingList = selectedShoppingList
    }
}
