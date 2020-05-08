//
//  FilterFavoriteMoviesByGenderInteractor.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 08/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class FilterFavoriteMoviesByGenderInteractor {

    unowned private let presenter: FilterFavoriteMoviesByGenderPresenterToInteractor

    init (presenter: FilterFavoriteMoviesByGenderPresenterToInteractor) {
        self.presenter = presenter
    }

}

// MARK: - FilterFavoriteMoviesByGenderInteractorToPresenter

extension FilterFavoriteMoviesByGenderInteractor: FilterFavoriteMoviesByGenderInteractorToPresenter {

}
