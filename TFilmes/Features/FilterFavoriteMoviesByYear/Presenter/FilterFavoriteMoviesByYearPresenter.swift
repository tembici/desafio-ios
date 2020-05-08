//
//  FilterFavoriteMoviesByYearPresenter.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class FilterFavoriteMoviesByYearPresenter {

    unowned private let view: FilterFavoriteMoviesByYearViewToPresenter

    private lazy var interactor: FilterFavoriteMoviesByYearInteractorToPresenter = {
        return FilterFavoriteMoviesByYearInteractor(presenter: self)
    }()

    init (view: FilterFavoriteMoviesByYearViewToPresenter) {
        self.view = view
    }

}

// MARK: - FilterFavoriteMoviesByYearPresenterToView

extension FilterFavoriteMoviesByYearPresenter: FilterFavoriteMoviesByYearPresenterToView {

    func viewDidLoad() {
        self.interactor.fetchAllYearsInFavorite()
    }

}

// MARK: - FilterFavoriteMoviesByYearPresenterToInteractor

extension FilterFavoriteMoviesByYearPresenter: FilterFavoriteMoviesByYearPresenterToInteractor {

    func didFetchAllYearsInFavorite(_ years: [Int]) {
        self.view.updateYears(with: years)
    }
}
