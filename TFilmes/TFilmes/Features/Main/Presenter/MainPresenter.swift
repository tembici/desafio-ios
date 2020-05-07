//
//  MainPresenter.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class MainPresenter {

    unowned private let view: MainViewToPresenter

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

    private func updateMoviesWithQuery(moviesToUpdate: [MainMovie]? = nil) {
        let movies = moviesToUpdate ?? self.mainMovies

        if self.currentQuery.isEmpty {
            self.view.updateMovies(with: movies)
        } else {
            let mainMovies = movies.filter { $0.originalTitle.lowercased().contains(self.currentQuery)}
            guard mainMovies.count > 0 else { return }
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

    func filterMainMovies(with query: String?) {
        guard let queryToFetch = query else { return }

        self.currentQuery = queryToFetch.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        self.view.removeMovies()
        self.updateMoviesWithQuery()
    }

    func favoriteChanged(mainMovie: MainMovie) {
        self.interactor.updateFavoriteState(of: mainMovie)
    }

}

// MARK: - MainPresenterToInteractorProtocol

extension MainPresenter: MainPresenterToInteractor {

    func didFetchMoviesOnApi(_ mainMovies: [MainMovie]) {
        self.mainMovies.append(contentsOf: mainMovies)
        self.updateMoviesWithQuery(moviesToUpdate: mainMovies)
    }
}
