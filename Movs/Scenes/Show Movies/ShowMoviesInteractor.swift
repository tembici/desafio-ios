//
//  ShowMoviesInteractor.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol ShowMoviesBusinessLogic {
    func fetchData(request: ShowMovies.fetchMovies.Request)
    func setAsFavorite(request: ShowMovies.favoriteMovie.Request)
    func queryMovies(request: ShowMovies.queryMovies.Request)
}

protocol ShowMoviesDataStore { }

class ShowMoviesInteractor: ShowMoviesBusinessLogic, ShowMoviesDataStore {
    
    var presenter: ShowMoviesPresentationLogic?
    var worker: ShowMoviesWorker?

    func fetchData(request: ShowMovies.fetchMovies.Request) {
        worker = ShowMoviesWorker()
        worker?.getMovies(for: 1) { movies in
            let response = ShowMovies.fetchMovies.Response(content: movies)
            self.presenter?.presentMovies(response: response)
        }
    }
    
    func setAsFavorite(request: ShowMovies.favoriteMovie.Request) {
        worker = ShowMoviesWorker()
        worker?.saveAsFavorite(movie: request.movie)
    }
    
    func queryMovies(request: ShowMovies.queryMovies.Request) {
        worker = ShowMoviesWorker()
        let content = worker?.queryMovies(keyword: request.keyword)
        let response = ShowMovies.queryMovies.Response(content: content)
        self.presenter?.presentQueriedMovies(response: response)
    }
}
