//
//  ShowFavoriteMoviesInteractor.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol ShowFavoriteMoviesBusinessLogic {
    func fetchFavoriteMovies(request: ShowFavoriteMovies.FetchFavoriteMovies.Request)
    func unfavoriteMovie(request: ShowFavoriteMovies.UnfavoriteMovie.Request)
}

protocol ShowFavoriteMoviesDataStore { }

class ShowFavoriteMoviesInteractor: ShowFavoriteMoviesBusinessLogic, ShowFavoriteMoviesDataStore {
   
    var presenter: ShowFavoriteMoviesPresentationLogic?
    var worker: ShowFavoriteMoviesWorker?

    func fetchFavoriteMovies(request: ShowFavoriteMovies.FetchFavoriteMovies.Request) {
        worker = ShowFavoriteMoviesWorker()
        let content = worker?.getFavoriteMovies()
        let response = ShowFavoriteMovies.FetchFavoriteMovies.Response(content: content)
        self.presenter?.presentFavoriteMovies(response: response)
    }
    
    func unfavoriteMovie(request: ShowFavoriteMovies.UnfavoriteMovie.Request) {
        worker = ShowFavoriteMoviesWorker()
        let content = worker?.unfavoriteMovies(movie: request.movie)
        let response = ShowFavoriteMovies.UnfavoriteMovie.Response(content: content)
        self.presenter?.presentUpdatedFavoriteMovies(response: response)
    }
}
