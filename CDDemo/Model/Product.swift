//
//  Product.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/24/24.
//

import Foundation

public struct Product: Hashable {
    let id: UUID
    var name: String
    var price: Float
}
