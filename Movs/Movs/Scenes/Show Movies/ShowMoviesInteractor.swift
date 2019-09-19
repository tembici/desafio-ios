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
}

protocol ShowMoviesDataStore {
    
}

class ShowMoviesInteractor: ShowMoviesBusinessLogic, ShowMoviesDataStore {
    var presenter: ShowMoviesPresentationLogic?
    var worker: ShowMoviesWorker?

    func fetchData(request: ShowMovies.fetchMovies.Request) {
        worker = ShowMoviesWorker()
    
        let response = ShowMovies.fetchMovies.Response()
        presenter?.presentMovies(response: response)
    }
}
