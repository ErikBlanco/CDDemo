//
//  AddProductViewModel.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//

import Foundation

protocol AddProductViewModelDelegate: AnyObject {
    
}

class AddProductViewModel: ObservableObject {
    weak var addProductViewModelDelegate: AddProductViewModelDelegate?
    private var productManager = ProductManager()
    
    func createProduct(shoppingListId id: UUID, productName: String, productPrice: Float) {
        let product = Product(id: UUID(), name: productName, price: productPrice)
        productManager.create(product: product, shoppingListId: id)
    }
}
