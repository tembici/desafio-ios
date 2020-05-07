//
//  FavoriteMoviesInteractor.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class FavoriteMoviesInteractor {

    unowned private let presenter: FavoriteMoviesPresenterToInteractor

    init (presenter: FavoriteMoviesPresenterToInteractor) {
        self.presenter = presenter
    }

}

// MARK: - FavoriteMoviesInteractorToPresenter

extension FavoriteMoviesInteractor: FavoriteMoviesInteractorToPresenter {

    func fetchFavoriteMovies() {
        let favoriteMovies = FavoriteMovieModel.getAll()

        var movies: [Movie] = []
        for favoriteMovie in favoriteMovies {
            let movie = Movie(favoriteMovieModel: favoriteMovie)

            movies.append(movie)
        }

        self.presenter.didFetchFavoriteMovies(movies)
    }

}
