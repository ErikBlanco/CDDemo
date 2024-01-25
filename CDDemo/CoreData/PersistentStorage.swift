//
//  PersistentStorage.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/24/24.
//

import CoreData
import Foundation

final class PersistentStorage {
    
    private init() { }
    static let shared = PersistentStorage()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CDDemo")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func saveContext() {
//        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        debugPrint(path[0])
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else { return nil }
            
            return result
        } catch {
            debugPrint(error)
        }
        return nil
    }
    
}
