//
//  CoreDataManager.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
  
    static let sharedManager = CoreDataManager()
    private init() {}
  
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Desafio_TemBici")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
  
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func resetAllRecord() {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
  
    func insertMovie(movie: Movie) -> Favorite? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        
        let favorite = NSManagedObject(entity: entity, insertInto: managedContext)
        favorite.setValue(movie.posterPath, forKey: "url")
        favorite.setValue(movie.id, forKey: "id")
        favorite.setValue(movie.title, forKeyPath: "name")
        favorite.setValue(movie.releaseDate, forKeyPath: "date")
        favorite.setValue(movie.overview, forKey: "overview")
    
        do {
            try managedContext.save()
            return favorite as? Favorite
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func getMovie(id: Int) -> Bool? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        do {
            let favorites = try managedContext.fetch(fetchRequest) as? [Favorite]
            return favorites?.contains { $0.id == id }
        } catch {
            return false
        }
    }
  
    //NO CASO IMPLEMENTEI O UPDATE MAS NÃO USARIA PARA ESSE APP
    func update(movie: Movie, favorite: Favorite) {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        do {
            favorite.setValue(movie.posterPath, forKey: "url")
            favorite.setValue(movie.id, forKey: "id")
            favorite.setValue(movie.title, forKeyPath: "name")
            favorite.setValue(movie.releaseDate, forKeyPath: "date")
            favorite.setValue(movie.overview, forKey: "overview")
      
            print("\(favorite.value(forKey: "url") ?? "")")
            print("\(favorite.value(forKey: "id") ?? "")")
            print("\(favorite.value(forKey: "name") ?? "")")
            print("\(favorite.value(forKey: "date") ?? "")")
            print("\(favorite.value(forKey: "overview") ?? "")")
            
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {}
      
        } catch {
            print("Error with request: \(error)")
        }
    }
  
    func delete(favorite: Favorite){
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        do {
            managedContext.delete(favorite)
        } catch {
            print(error)
        }
    
        do {
            try managedContext.save()
        } catch {
            print("\(error)")
        }
    }
  
    func fetchMoviesFavorited() -> [Favorite]? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
    
        do {
            let favorites = try managedContext.fetch(fetchRequest)
            return favorites as? [Favorite]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
  
    func delete(id: Int) -> [Favorite]? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "id == %@" ,id)
        do {
            let favorites = try managedContext.fetch(fetchRequest)
            var arrRemovedFavorites = [Favorite]()
            for i in favorites {
                managedContext.delete(i)
                try managedContext.save()
                arrRemovedFavorites.append(i as! Favorite)
            }
            return arrRemovedFavorites
      
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
}
