//
//  CoreDataManager.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation
import CoreData

public final class CoreDataManager {
    
    // Avoid instantiation
    private init() {}
    
    // Shared Resource
    public static let shared: CoreDataManager = CoreDataManager()
    
    // MARK: - Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        
        guard let bundle = Bundle.main.url(forResource: "TheMovieDB", withExtension: "momd") else {
            fatalError("Bundle not found!")
        }
        
        guard let objectModel: NSManagedObjectModel = NSManagedObjectModel(contentsOf: bundle) else {
            fatalError("Object Model not found!")
        }
        
        let container: NSPersistentContainer = NSPersistentContainer(name: "TheMovieDB", managedObjectModel: objectModel)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private lazy var viewContext: NSManagedObjectContext = {
        let viewContext = self.persistentContainer.newBackgroundContext()
        viewContext.mergePolicy = NSMergePolicy.overwrite
        return viewContext
    }()
    
    // MARK: - Core Data Saving support
    
    public func create(_ entity: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entity, in: self.viewContext)!
    }
    
    public func insert(_ object: NSManagedObject) throws {
        let context: NSManagedObjectContext = self.viewContext
        context.insert(object)
        do {
            try context.save()
        } catch {
            context.delete(object)
            throw error
        }
    }
    
    public func update(_ object: NSManagedObject) throws {
        try object.managedObjectContext?.save()
    }
    
    public func delete(_ object: NSManagedObject) throws {
        let context = object.managedObjectContext
        context?.delete(object)
        do {
            try context?.save()
        } catch {
            context?.insert(object)
            throw error
        }
    }
    
    public func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] {
        let context: NSManagedObjectContext = self.viewContext
        return try context.fetch(request)
    }
    
    public func clear() {
        let context: NSManagedObjectContext = self.viewContext
        for entity in self.persistentContainer.managedObjectModel.entities {
            guard let name = entity.name else { continue }
            let query = NSFetchRequest<NSFetchRequestResult>(entityName: name)
            let request = NSBatchDeleteRequest(fetchRequest: query)
            do {
                try context.execute(request)
                try context.save()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
}
