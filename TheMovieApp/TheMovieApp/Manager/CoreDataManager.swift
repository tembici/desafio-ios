//
//  CoreDataManager.swift
//  TheMovieApp
//
//  Created by Wilson Kim on 27/06/19.
//  Copyright © 2019 WilsonKim. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    let appDelegate:AppDelegate
    let context:NSManagedObjectContext
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func saveObject(_ object:NSManagedObject, successCompletion: @escaping() -> Void, failCompletion: @escaping(_ error: Error) -> Void) {
        do {
            try context.save()
            successCompletion()
            return
        } catch {
            context.delete(object)
            failCompletion(error)
        }
    }
    
    func getFavoriteMovies() -> [MovieData]? {
        let fetchRequest = NSFetchRequest<MovieData>(entityName: "MovieData")
        do {
            let list = try context.fetch(fetchRequest)
            return list
        } catch {
            print("error 321")
        }
        return nil
    }
}
