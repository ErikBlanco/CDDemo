//
//  CDProduct+ConvertToProduct.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//

import Foundation

extension CDProduct {
    func convertToProduct() -> Product {
        return Product(id: self.id!, name: self.unwrappedName, price: self.price)
    }
}
