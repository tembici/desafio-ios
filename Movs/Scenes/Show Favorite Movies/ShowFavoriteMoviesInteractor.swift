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
}

protocol ShowFavoriteMoviesDataStore { }

class ShowFavoriteMoviesInteractor: ShowFavoriteMoviesBusinessLogic, ShowFavoriteMoviesDataStore {
   
    var presenter: ShowFavoriteMoviesPresentationLogic?
    var worker: ShowFavoriteMoviesWorker?

    func fetchFavoriteMovies(request: ShowFavoriteMovies.FetchFavoriteMovies.Request) {
        worker = ShowFavoriteMoviesWorker()
        let content = worker?.getFavoriteMovies()
        let response = ShowFavoriteMovies.FetchFavoriteMovies.Response(content: content)
        presenter?.presentFavoriteMovies(response: response)
    }
}
