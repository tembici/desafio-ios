//
//  FilterFavoriteMoviesByGenderPresenter.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 08/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class FilterFavoriteMoviesByGenderPresenter {

    unowned private let view: FilterFavoriteMoviesByGenderViewToPresenter

    private lazy var interactor: FilterFavoriteMoviesByGenderInteractorToPresenter = {
        return FilterFavoriteMoviesByGenderInteractor(presenter: self)
    }()

    init (view: FilterFavoriteMoviesByGenderViewToPresenter) {
        self.view = view
    }

}

// MARK: - FilterFavoriteMoviesByGenderPresenterToView

extension FilterFavoriteMoviesByGenderPresenter: FilterFavoriteMoviesByGenderPresenterToView {

    func viewDidLoad() {

    }

}

// MARK: - FilterFavoriteMoviesByGenderPresenterToInteractor

extension FilterFavoriteMoviesByGenderPresenter: FilterFavoriteMoviesByGenderPresenterToInteractor {

}
