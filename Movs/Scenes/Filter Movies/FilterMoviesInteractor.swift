//
//  SearchMoviesInteractor.swift
//  Movs
//
//  Created by Miguel Pimentel on 24/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol FilterMoviesBusinessLogic {
    func fetchMoviesByGenre(request: FilterMovies.FilterByGenre.Request)
    func fetchGenders(request: FilterMovies.FetchGenders.Request)
}

protocol SearchMoviesDataStore { }

class FilterMoviesInteractor: FilterMoviesBusinessLogic, SearchMoviesDataStore {

    var presenter: FilterMoviesPresentationLogic?
    var worker: SearchMoviesWorker?

    // MARK: Business Logic

    func fetchGenders(request: FilterMovies.FetchGenders.Request) {
        worker = SearchMoviesWorker()
        worker?.getGenres { genres in
            let response = FilterMovies.FetchGenders.Response(content: genres)
            self.presenter?.presentGenres(response: response)
        }
    }
    
    func fetchMoviesByGenre(request: FilterMovies.FilterByGenre.Request) {
        worker = SearchMoviesWorker()
        worker?.getMovies(by: request.genreId, page: request.page) { movies in
            let response = FilterMovies.FilterByGenre.Response(content: movies)
            self.presenter?.presentMovies(response: response)
        }
    }
}
