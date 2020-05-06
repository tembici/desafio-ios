//
//  MainPresenter.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class MainPresenter {

    private let view: MainViewToPresenter

    private lazy var interactor: MainInteractorToPresenter = {
        return MainInteractor(presenter: self)
    }()

    init (view: MainViewToPresenter) {
        self.view = view
    }

    private var pageToFetch = 0

    private func fetchMovies() {
        self.pageToFetch += 1
        self.interactor.fetchMoviesOnApi(with: self.pageToFetch)
    }

}

// MARK: - MainPresenterToViewProtocol

extension MainPresenter: MainPresenterToView {

    func viewDidLoad() {
        self.fetchMovies()
    }

}

// MARK: - MainPresenterToInteractorProtocol

extension MainPresenter: MainPresenterToInteractor {

}
