//
//  ShowMoviesPresenter.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol ShowMoviesPresentationLogic {
    func presentSomething(response: ShowMovies.Something.Response)
}

class ShowMoviesPresenter: ShowMoviesPresentationLogic {
    weak var viewController: ShowMoviesDisplayLogic?

    // MARK: Do something

    func presentSomething(response: ShowMovies.Something.Response) {
        let viewModel = ShowMovies.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
