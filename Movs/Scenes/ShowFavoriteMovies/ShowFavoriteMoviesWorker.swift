//
//  ShowFavoriteMoviesWorker.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

class ShowFavoriteMoviesWorker {
    
    private let movieManager = MovieManager()
    
    func getFavoriteMovies() ->  [Movie]? {
        return movieManager.getFavorite()
    }
    
    /// Retrieves the favorite movie list updated
    func unfavoriteMovies(movie: Movie) -> [Movie]? {
        _ =  self.movieManager.update(movie: movie)
        return self.movieManager.getFavorite()
    }
}
