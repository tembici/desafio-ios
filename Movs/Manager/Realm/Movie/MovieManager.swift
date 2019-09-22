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
    private var movies: [Movie]?
    
    init() { self.movies = adapter.getAll() }
    
    func getAll() -> [Movie]? {
        return movies
    }
    
    func getByCategorie(category: Movie.Category) -> [Movie]? {
        return movies?.filter { $0.category == category }
    }
    
    func getByGenre(genreId: Int) -> [Movie]? {
        return movies?.filter { $0.genres?.contains(genreId) ?? false }
    }
    
    func get(identifier: Int) -> Movie? {
        return adapter.get(identifier: identifier)
    }
    
    func insert(movie: Movie) -> Movie? {
        return adapter.insert(movie: movie)
    }
    
    func update(movie: Movie) -> Movie? {
        return adapter.update(movie: movie)
    }
    
    func delete(identifier: Int) -> Movie? {
        return adapter.delete(identifier: identifier)
    }
    
    func insertMany(movies: [Movie]) -> [Movie] {
        var updatedMovies: [Movie] = []
        for movie in movies {
            if let updatedMovie = adapter.insert(movie: movie) {
                updatedMovies.append(updatedMovie)
            }
        }
        
        return updatedMovies
    }
    
    func updateMany(movies: [Movie]) -> [Movie] {
        var updatedMovies: [Movie] = []
        for movie in movies {
            if let updatedMovie = adapter.update(movie: movie) {
                updatedMovies.append(updatedMovie)
            }
        }
        
        return updatedMovies
    }
}

