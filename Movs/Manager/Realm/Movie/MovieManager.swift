//
//  MovieManager.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

class MovieManager {
    
    private var adapter = MovieRealmAdapter()

    func getAll() -> [Movie]? {
        return adapter.getAll()
    }
    
    func getByCategorie(category: Movie.Category) -> [Movie]? {
        return self.getAll()?.filter { $0.category == category }
    }
    
    func getFavorite() -> [Movie]? {
        return self.getAll()?.filter { $0.isFavorite == .favorite }
    }
    
    func getByGenre(genreId: Int) -> [Movie]? {
        return self.getAll()?.filter { $0.genres?.contains(genreId) ?? false }
    }
    
    func getByKeyword(with keyword: String) -> [Movie]? {
        return self.getAll()?.filter { $0.title?.contains(keyword) ?? false  }
    }
    
    func get(identifier: Int) -> Movie? {
        return adapter.get(identifier: identifier)
    }
    
    func insert(movie: Movie) -> Movie? {
        return adapter.insertAndUpdate(movie: movie)
    }
    
    func update(movie: Movie) -> Movie? {
        return adapter.insertAndUpdate(movie: movie)
    }
    
    func delete(identifier: Int) -> Movie? {
        return adapter.delete(identifier: identifier)
    }
    
    func insertMany(movies: [Movie]) -> [Movie] {
        var updatedMovies: [Movie] = []
        for movie in movies {
            if let updatedMovie = adapter.insertAndUpdate(movie: movie) {
                updatedMovies.append(updatedMovie)
            }
        }
        
        return updatedMovies
    }
    
    func updateMany(movies: [Movie]) -> [Movie] {
        var updatedMovies: [Movie] = []
        for movie in movies {
            if let updatedMovie = adapter.insertAndUpdate(movie: movie) {
                updatedMovies.append(updatedMovie)
            }
        }
        
        return updatedMovies
    }
}

