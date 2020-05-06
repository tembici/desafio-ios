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

    private var mainMovies: [MainMovie] = []

    private var currentQuery = ""

    private func fetchMovies() {
        self.pageToFetch += 1
        self.interactor.fetchMoviesOnApi(with: self.pageToFetch)
    }

    private func updateMoviesWithQuery() {
        let query = self.currentQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if query.isEmpty {
            self.view.updateMovies(with: self.mainMovies)
        } else {
            let mainMovies = self.mainMovies.filter { $0.originalTitle.lowercased().contains(query)}
            self.view.updateMovies(with: mainMovies)
        }
    }

}

// MARK: - MainPresenterToViewProtocol

extension MainPresenter: MainPresenterToView {

    func viewDidLoad() {
        self.fetchMovies()
    }

    func fetchMoreMovies() {
        self.fetchMovies()
    }

}

// MARK: - MainPresenterToInteractorProtocol

extension MainPresenter: MainPresenterToInteractor {

    func didFetchMoviesOnApi(_ mainMovies: [MainMovie]) {
        self.mainMovies = mainMovies
        self.updateMoviesWithQuery()
    }
}
