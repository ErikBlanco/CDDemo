//
//  CDShoppingList+ConvertToShoppingList.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/24/24.
//

import Foundation

extension CDShoppingList {
    func convertToShoppingList() -> ShoppingList {
        var products: [Product] = []
        self.cdProductArray.forEach { cdProduct in
            let product = Product(id: cdProduct.id!, name: cdProduct.unwrappedName, price: cdProduct.price)
            products.append(product)
        }
        
        return ShoppingList(id: self.id!, name: self.unwrappedName, products: products)
    }
}
