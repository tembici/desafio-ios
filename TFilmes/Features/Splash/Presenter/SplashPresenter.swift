//
//  SplashPresenter.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class SplashPresenter {

    unowned private let view: SplashViewToPresenter

    private lazy var interactor: SplashInteractorToPresenter = {
        return SplashInteractor(presenter: self)
    }()

    init (view: SplashViewToPresenter) {
        self.view = view
    }

}

// MARK: - SplashPresenterToView

extension SplashPresenter: SplashPresenterToView {

    func viewDidLoad() {
        self.interactor.fetchGenres()
    }

    func tryToGetGenresTapped() {
        self.interactor.fetchGenres()
    }

}

// MARK: - SplashPresenterToInteractor

extension SplashPresenter: SplashPresenterToInteractor {

    func didFetchGenres() {
        self.view.continueApp()
    }

    func didFailToFetchGenres() {
        self.view.showErrorMessage()
    }

}
