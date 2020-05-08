//
//  FilterFavoriteMoviesByYearInteractor.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class FilterFavoriteMoviesByYearInteractor {

    unowned private let presenter: FilterFavoriteMoviesByYearPresenterToInteractor

    init (presenter: FilterFavoriteMoviesByYearPresenterToInteractor) {
        self.presenter = presenter
    }

}

// MARK: - FilterFavoriteMoviesByYearInteractorToPresenter

extension FilterFavoriteMoviesByYearInteractor: FilterFavoriteMoviesByYearInteractorToPresenter {

    func fetchAllYearsInFavorite() {
        let allYears = FavoriteMovieModel.getAll().compactMap { $0.releaseDate?.getYear() }
        let uniqueYearsSet = Set<Int>(allYears)
        let uniqueYearsArray = Array(uniqueYearsSet).sorted()
        self.presenter.didFetchAllYearsInFavorite(uniqueYearsArray)
    }

}
