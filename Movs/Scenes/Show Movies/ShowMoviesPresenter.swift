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
    func presentQueriedMovies(response: ShowMovies.queryMovies.Response)
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
    
    func presentQueriedMovies(response: ShowMovies.queryMovies.Response) {
        if let content = response.content {
            let viewModel = ShowMovies.queryMovies.ViewModel(content: content)
            self.viewController?.displayQueriedMovies(viewModel: viewModel)
        }
    }
}
