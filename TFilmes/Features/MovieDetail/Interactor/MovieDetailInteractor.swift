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

}
