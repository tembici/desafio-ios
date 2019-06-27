//
//  CoreDataManager.swift
//  TheMovieApp
//
//  Created by Wilson Kim on 27/06/19.
//  Copyright © 2019 WilsonKim. All rights reserved.
//

import Foundation

class CoreDataManager {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<MovieData>(entityName: "MovieData")
    
    func saveMovie(_ movie:MovieViewModel) {
        //        let mov = MovieData(context: context)
        //        mov.genres = [1,2,3] as NSObject
        //        do {
        //            try context.save()
        //        } catch {
        //            print("error 123")
        //        }
    }
    
    func bindToMovieData(_ movie:MovieViewModel) -> MovieData {
        
    }
    
    func getFavoriteMovies() -> [MovieViewModel] {
        //        let fetchRequest = NSFetchRequest<MovieData>(entityName: "MovieData")
        //        do {
        //            let list = try context.fetch(fetchRequest)
        //            print(list[0].genres)
        //        } catch {
        //            print("error 321")
        //        }
    }
    
    func bindToMovieViewModel(_ movie:MovieData) -> MovieViewModel {
        
    }
}
