//
//  MovieDetailPresenter.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class MovieDetailPresenter {

    unowned private let view: MovieDetailViewToPresenter

    private lazy var interactor: MovieDetailInteractorToPresenter = {
        return MovieDetailInteractor(presenter: self)
    }()

    init (view: MovieDetailViewToPresenter) {
        self.view = view
    }

}

// MARK: - MovieDetailPresenterToView

extension MovieDetailPresenter: MovieDetailPresenterToView {

    func favoriteButtonTapped() {
        guard let movie = self.view.movie else { return }
        self.interactor.updateFavoriteState(of: movie)
    }

}

// MARK: - MovieDetailPresenterToInteractor

extension MovieDetailPresenter: MovieDetailPresenterToInteractor {

}
