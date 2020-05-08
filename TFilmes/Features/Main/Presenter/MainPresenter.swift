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

    private var pageToFetch = 1
    private var movies: [Movie] = []

    private var currentQuery = ""

    private func fetchMovies() {
        self.interactor.fetchMoviesOnApi(withPage: self.pageToFetch)
        self.pageToFetch += 1
    }

    private func updateMoviesWithQuery(moviesToUpdate: [Movie]? = nil) {
        let movies = moviesToUpdate ?? self.movies

        if self.currentQuery.isEmpty {
            self.view.updateMovies(with: movies)
        } else {
            let movies = movies.filter {
                $0.originalTitle
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()
                    .contains(self.currentQuery)
            }
            self.view.updateMovies(with: movies)
        }
    }

}

// MARK: - MainPresenterToView

extension MainPresenter: MainPresenterToView {

    func viewDidAppear() {
        self.fetchMovies()
    }

    func fetchMoreMovies() {
        self.fetchMovies()
    }

    func filterMovies(with query: String?) {
        guard let queryToFetch = query else { return }

        self.currentQuery = queryToFetch.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        self.view.removeMovies()
        self.updateMoviesWithQuery()
    }

    func favoriteChanged(movie: Movie) {
        self.interactor.updateFavoriteState(of: movie)
    }

    func tryToGetMoviesTapped() {
        self.interactor.fetchMoviesOnApi(withPage: self.pageToFetch)
    }

}

// MARK: - MainPresenterToInteractorProtocol

extension MainPresenter: MainPresenterToInteractor {

    func didFetchMoviesOnApi(_ movies: [Movie]) {
        self.movies.append(contentsOf: movies)
        self.updateMoviesWithQuery(moviesToUpdate: movies)
    }

    func didFailToFetchMovies() {
        self.view.showErrorState()
    }

}
