//
//  SearchMoviesPresenter.swift
//  Movs
//
//  Created by Miguel Pimentel on 24/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol FilterMoviesPresentationLogic {
    func presentMovies(response: FilterMovies.FilterByGenre.Response)
    func presentGenres(response: FilterMovies.FetchGenders.Response)
}

class FilterMoviesPresenter: FilterMoviesPresentationLogic {
    
    weak var viewController: FilterMoviesDisplayLogic?

    // MARK: Presentation Logic

    func presentMovies(response: FilterMovies.FilterByGenre.Response) {
        if let content = response.content {
            let viewModel = FilterMovies.FilterByGenre.ViewModel(content: content)
            viewController?.displayMovies(viewModel: viewModel)
        }
    }
    
    func presentGenres(response: FilterMovies.FetchGenders.Response) {
        if let genres = response.content {
            let viewModel = FilterMovies.FetchGenders.ViewModel(content: genres)
            self.viewController?.displayGenres(viewModel: viewModel)
        }
    }
}
