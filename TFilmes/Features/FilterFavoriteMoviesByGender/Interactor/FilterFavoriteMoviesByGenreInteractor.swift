//
//  FilterFavoriteMoviesByGenreInteractor.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 08/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class FilterFavoriteMoviesByGenreInteractor {

    unowned private let presenter: FilterFavoriteMoviesByGenrePresenterToInteractor

    init (presenter: FilterFavoriteMoviesByGenrePresenterToInteractor) {
        self.presenter = presenter
    }

}

// MARK: - FilterFavoriteMoviesByGenreInteractorToPresenter

extension FilterFavoriteMoviesByGenreInteractor: FilterFavoriteMoviesByGenreInteractorToPresenter {

    func fetchAllGenreInFavorite() {
        let allGenres = FavoriteMovieModel.getAll()
            .flatMap { $0.genres }
            .compactMap { GenreFilterItem(id: $0.id, name: $0.name) }

        let uniqueGenresSet = Set<GenreFilterItem>(allGenres)
        let uniqueGenresArray = Array(uniqueGenresSet).sorted(by: { $0.name < $1.name })
        self.presenter.didFetchAllGenresInFavorite(uniqueGenresArray)
    }

}
