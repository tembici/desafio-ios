//
//  ShowMoviesPresenter.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol ShowMoviesPresentationLogic {
    func presentMovies(response: ShowMovies.fetchMovies.Response)
}

class ShowMoviesPresenter: ShowMoviesPresentationLogic {
    
    weak var viewController: ShowMoviesDisplayLogic?

    // MARK: - Presentation Logic -

    func presentMovies(response: ShowMovies.fetchMovies.Response) {
        if let content = response.content {
            let viewModel = ShowMovies.fetchMovies.ViewModel(content: content)
            self.viewController?.displayMovies(viewModel: viewModel)
        }
    }
}
