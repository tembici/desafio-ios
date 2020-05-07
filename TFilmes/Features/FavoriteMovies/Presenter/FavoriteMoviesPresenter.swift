//
//  FavoriteMoviesPresenter.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class FavoriteMoviesPresenter {

    unowned private let view: FavoriteMoviesViewToPresenter

    private lazy var interactor: FavoriteMoviesInteractorToPresenter = {
        return FavoriteMoviesInteractor(presenter: self)
    }()

    init (view: FavoriteMoviesViewToPresenter) {
        self.view = view
    }

}

// MARK: - FavoriteMoviesPresenterToView

extension FavoriteMoviesPresenter: FavoriteMoviesPresenterToView {

    func viewDidLoad() {
        self.interactor.fetchFavoriteMovies()
    }

}

// MARK: - FavoriteMoviesPresenterToInteractor

extension FavoriteMoviesPresenter: FavoriteMoviesPresenterToInteractor {

    func didFetchFavoriteMovies(_ movies: [Movie]) {
        self.view.updateMovies(with: movies)
    }
}
