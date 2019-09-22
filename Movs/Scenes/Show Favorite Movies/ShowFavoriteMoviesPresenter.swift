//
//  ShowFavoriteMoviesPresenter.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol ShowFavoriteMoviesPresentationLogic {
    func presentFavoriteMovies(response: ShowFavoriteMovies.FetchFavoriteMovies.Response)
}

class ShowFavoriteMoviesPresenter: ShowFavoriteMoviesPresentationLogic {
    weak var viewController: ShowFavoriteMoviesDisplayLogic?


    func presentFavoriteMovies(response: ShowFavoriteMovies.FetchFavoriteMovies.Response) {
        let viewModel = ShowFavoriteMovies.FetchFavoriteMovies.ViewModel()
        viewController?.displayFavoriteMovies(viewModel: viewModel)
    }
}
