//
//  ShoppingList.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/24/24.
//

import Foundation

struct ShoppingList {
    let id: UUID
    var name: String
    var products: [Product]
    
    static let exampleCollection = [
        ShoppingList(id: UUID(), name: "Clothing", products: [
            Product(id: UUID(), name: "Pants", price: 10.0),
            Product(id: UUID(), name: "Shirt", price: 20.0),
            Product(id: UUID(), name: "Shoes", price: 30.0),
        ]),
        ShoppingList(id: UUID(), name: "Food", products: [
            Product(id: UUID(), name: "Bread", price: 10.0),
            Product(id: UUID(), name: "Milk", price: 20.0),
            Product(id: UUID(), name: "Ham", price: 30.0),
        ]),
        ShoppingList(id: UUID(), name: "Home", products: [
            Product(id: UUID(), name: "Toaster", price: 10.0),
            Product(id: UUID(), name: "Microwave", price: 20.0),
            Product(id: UUID(), name: "Sofa", price: 30.0),
        ]),
    ]
}
