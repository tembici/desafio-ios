//
//  CoreDataStack.swift
//  Movs
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    var context: NSManagedObjectContext?
    
    // MARK: - Core Data stack
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Movs")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        do {
            return try NSPersistentStoreCoordinator.coordinator(name: "Movs")
        } catch {
            print("CoreData: Unresolved error \(error)")
        }
        return nil
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    init() {
        if #available(iOS 10.0, *) {
            context = persistentContainer.viewContext
        } else {
            context = managedObjectContext
        }
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if #available(iOS 10.0, *) {
            context = persistentContainer.viewContext
        } else {
            context = managedObjectContext
        }
        if (context?.hasChanges)! {
            do {
                try context?.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

