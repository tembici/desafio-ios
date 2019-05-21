//
//  MoviesInteractor.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

protocol MoviesInteractorInput{
    
    var output: MoviesInteractorOutput?{ get set}
    
    func fetchMovies()
    func setFavoriteMovie(id: Int)
    func findMovie(id: Int)
}

protocol MoviesInteractorOutput: class{
    
    func fetchedMovies(movies: [MovieEntity])
    func foundMovie(_ movie: MovieEntity)
}

final class MoviesInteractor: MoviesInteractorInput{
    
    var output: MoviesInteractorOutput?
    var manager: MoviesManager?
    
    var movies: [MovieEntity] = []
    
    func fetchMovies() {
        
        self.manager?.getMovies(completion: { (movies) in
            
            self.movies = movies
            self.output?.fetchedMovies(movies: self.movies)
        })
    }
    
    func setFavoriteMovie(id: Int) {
        
        let queue = DispatchQueue(label: "favorite movie")
        
        queue.async {
            if FavoritesManager.isFavorite(id){
                FavoritesManager.unfavorite(id)
            }
            else{
                FavoritesManager.setFavorite(id)
            }
        }
//            self.output?.fetchedMovies(movies: self.movies)
    }
    
    func findMovie(id: Int) {
        
        guard let movie = MovieEntity.getMovie(in: self.movies, byId: id) else{ return }
        
        self.output?.foundMovie(movie)
    }
}
