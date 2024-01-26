//
//  ShoppingListDataRepository.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//

import CoreData
import Foundation

protocol ShoppingListRepository {
    func create(shoppingList: ShoppingList)
    func getAll() -> [ShoppingList]?
    func getAllByBatchesOf(_ n: Int) -> [ShoppingList]?
    func get(byIdentifier id: UUID) -> ShoppingList?
    func update(shoppingList: ShoppingList) -> Bool
    func delete(id: UUID) -> Bool
}


struct ShoppingListDataRepository: ShoppingListRepository {
    func create(shoppingList: ShoppingList) {
        let cdShoppingList = CDShoppingList(context: PersistentStorage.shared.context)
        cdShoppingList.id = shoppingList.id
        cdShoppingList.name = shoppingList.name
        
        var cdProducts: [CDProduct] = []
        shoppingList.products.forEach { product in
            let cdProduct = CDProduct(context: PersistentStorage.shared.context)
            cdProduct.id = product.id
            cdProduct.name = product.name
            cdProduct.price = product.price
            cdProducts.append(cdProduct)
        }
        cdShoppingList.product = NSSet(array: cdProducts)
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [ShoppingList]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDShoppingList.self)
        var shoppingLists: [ShoppingList] = []
        
        shoppingLists.append(contentsOf: result?.map { $0.convertToShoppingList() } ?? [])

        return shoppingLists
    }
    
    func getAllByBatchesOf(_ n: Int) -> [ShoppingList]? {
        let fetchRequest: NSFetchRequest<CDShoppingList> = CDShoppingList.fetchRequest()
        fetchRequest.fetchBatchSize = n
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        var shoppingLists: [ShoppingList] = []
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest)
            shoppingLists.append(contentsOf: result.map { $0.convertToShoppingList() })
        } catch {
            debugPrint(error)
        }
        
        return shoppingLists
    }
    
    func get(byIdentifier id: UUID) -> ShoppingList? {
        let result = getCDShoppingList(byIdentifier: id)
        guard result != nil else { return nil }
        return result?.convertToShoppingList()
    }
    
    func update(shoppingList: ShoppingList) -> Bool {
        let cdShoppingList = getCDShoppingList(byIdentifier: shoppingList.id)
        guard cdShoppingList != nil else { return false }
        cdShoppingList!.name = shoppingList.name
        
        var cdProducts: [CDProduct] = []
        shoppingList.products.forEach { product in
            let cdProduct = CDProduct(context: PersistentStorage.shared.context)
            cdProduct.id = product.id
            cdProduct.name = product.name
            cdProduct.price = product.price
            cdProducts.append(cdProduct)
        }
        
        cdShoppingList!.product = NSSet(array: cdProducts)
        
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(id: UUID) -> Bool {
        let cdShoppingList = getCDShoppingList(byIdentifier: id)
        guard cdShoppingList != nil else { return false }
        
        PersistentStorage.shared.context.delete(cdShoppingList!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func getCDShoppingList(byIdentifier id: UUID) -> CDShoppingList? {
        let fetchRequest = NSFetchRequest<CDShoppingList>(entityName: "CDShoppingList")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else { return nil }
            return result
        } catch {
            debugPrint(error)
        }
        
        return nil
    }
}
