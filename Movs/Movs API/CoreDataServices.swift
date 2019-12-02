//
//  CoreDataServices.swift
//  Movs
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import Foundation
import CoreData

class CoreDataServices {
    
    static let shared = CoreDataServices()
    
    func saveFavoriteMovie(id: String, posterPath: String, releaseDate: String, title: String, overview: String) {
         let newItem = NSEntityDescription.insertNewObject(forEntityName: Favorites.entityName, into: CoreDataStack.shared.context!) as! Favorites
        
         newItem.overview =  overview
         newItem.id =  id
         newItem.posterPath =  posterPath
         newItem.releaseDate =  releaseDate
         newItem.title =  title
        
        CoreDataStack.shared.saveContext()
    }
    
    func getFavoriteMovies(withPredicates queries: [NSPredicate], distinct result: Bool) -> [Favorites] {
    
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Favorites.entityName)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: queries)
        fetchRequest.returnsDistinctResults = result
        
        do {
            let response = try CoreDataStack.shared.context!.fetch(fetchRequest)
            return response as! [Favorites]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [Favorites]()
        }
    }
    
    func deleteItem(object item: NSManagedObject) {
        CoreDataStack.shared.context!.delete(item)
    }
    
}
