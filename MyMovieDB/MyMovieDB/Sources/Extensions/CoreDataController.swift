//
//  CoreDataController.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 09/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation
import CoreData

class CoreDataController {
    
    //Try remove some other object in database with the same id.
    func saveOrUpdate(movie: MovieResult) throws {
        guard let movieManagedObject = movie.toNSManagedObject() else { return }
        
        do {
            if let movies = try CoreDataHelper().getData(in: Entitys.Movie) {
                for localMovie in movies {
                    if let localMovieId = localMovie.value(forKey: "id") as? Int, localMovieId == movie.id {
                        if movie.favorite {
                            try CoreDataHelper().saveSingleObject(object: movieManagedObject)
                        } else {
                            try CoreDataHelper().deleteData(object: localMovie, in: Entitys.Movie)
                        }
                    }
                }
            }
        } catch {
            // ...
        }
    }
}
