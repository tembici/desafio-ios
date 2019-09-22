//
//  GenreManager.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

class GenreManager {
    
    private var adapter: GenreRealmAdapter? = GenreRealmAdapter()
    
    func getAll() -> [Genre]? {
        if let genreAdapter = self.adapter {
            return genreAdapter.getAll()
        }
        
        return []
    }
    
    func get(identifier: Int) -> Genre? {
        return adapter?.get(identifier: identifier)
    }
    
    func insert(genre: Genre) {
        adapter?.insert(genre: genre)
    }
    
    func update(movie: Genre) -> Genre? {
        return adapter?.update(genre: movie)
    }
    
    func delete(identifier: Int) -> Genre? {
        return adapter?.delete(identifier: identifier)
    }
    
    func insertMany(genres: [Genre]) {
        for genre in genres {
            adapter?.insert(genre: genre)
        }
    }
    
    func updateMany(genres: [Genre]) -> [Genre] {
        var updatedGenres: [Genre] = []
        for genre in genres {
            if let updatedGenre = adapter?.update(genre: genre){
                updatedGenres.append(updatedGenre)
            }
        }
        
        return genres
    }
}
