//
//  FavoritesInteractor.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

protocol FavoritesInteractorInput{
    
    var output: FavoritesInteractorOutput?{ get set}
    
    func fetchMovies()
}

protocol FavoritesInteractorOutput: class{
    
    func foundFavoriteMovies(items: [FavoriteItem])
}

final class FavoritesInteractor: FavoritesInteractorInput{
    
    weak var output: FavoritesInteractorOutput?
    var manager: MoviesManager
    
    var movies: [MovieEntity] = []
    
    init(manager: MoviesManager){
        self.manager = manager
    }
    
    func fetchMovies(){
        
        self.manager.getMovies(completion: { (movies) in
            
            self.movies = movies

            let favoriteItems = FavoriteMapper.make(from: self.movies)
            self.output?.foundFavoriteMovies(items: favoriteItems)
        })
    }
}
