//
//  ProductManager.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//

import Foundation

struct ProductManager {
    private let _productDataRepository = ProductDataRepository()
    
    func create(product: Product, shoppingListId: UUID) {
        _productDataRepository.create(product: product, shoppingListId: shoppingListId)
    }
    
    func fetchProduct(byShoppingId id: UUID) -> [Product]? {
        return _productDataRepository.getAll(byShoppingId: id)
    }
}
