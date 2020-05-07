//
//  MovieDetailInteractor.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class MovieDetailInteractor {

    unowned private let presenter: MovieDetailPresenterToInteractor

    init (presenter: MovieDetailPresenterToInteractor) {
        self.presenter = presenter
    }

}

// MARK: - MovieDetailInteractorToPresenter

extension MovieDetailInteractor: MovieDetailInteractorToPresenter {

    func updateFavoriteState(of movie: Movie) {
        if movie.favorite {
            let imageName = MovieLocalImage.save(imageData: movie.image?.pngData(), imageURL: movie.imageURL)
            FavoriteMovieModel.create(
                id: movie.id,
                originalTitle: movie.originalTitle,
                overview: movie.overview,
                releaseDate: movie.releaseDate,
                imageName: imageName,
                genreIds: movie.genreIds
            )
        } else {
            MovieLocalImage.delete(imageURL: movie.imageURL)
            FavoriteMovieModel.deleteBy(id: movie.id)
        }
    }

}
