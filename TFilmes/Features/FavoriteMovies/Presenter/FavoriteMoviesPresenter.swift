//
//  FavoriteMoviesPresenter.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class FavoriteMoviesPresenter {

    unowned private let view: FavoriteMoviesViewToPresenter

    private lazy var interactor: FavoriteMoviesInteractorToPresenter = {
        return FavoriteMoviesInteractor(presenter: self)
    }()

    init (view: FavoriteMoviesViewToPresenter) {
        self.view = view
    }

    private var currentYearsFilter: [Int] = []
    private var currentGenreIdsFilter: [Int] = []
    private var searchQuery: String = ""

    private func fetchFavoriteMovies() {
        self.interactor.fetchFavoriteMovies(
            withSearchQuery: self.searchQuery,
            inYears: self.currentYearsFilter,
            inGenreIds: self.currentGenreIdsFilter
        )
    }

    private func checkFilters() {
        if self.currentYearsFilter.isEmpty && self.currentYearsFilter.isEmpty {
            self.view.setRemoveFilterIsHiden()
        } else {
            self.view.setRemoveFilterIsVisible()
        }
    }

}

// MARK: - FavoriteMoviesPresenterToView

extension FavoriteMoviesPresenter: FavoriteMoviesPresenterToView {

    var yearsFilter: [Int] {
        self.currentYearsFilter
    }

    var genreIdsFilter: [Int] {
        self.currentGenreIdsFilter
    }

    func viewDidAppear() {
        self.fetchFavoriteMovies()
    }

    func filterMovies(with searchQuery: String?) {
        self.searchQuery = searchQuery ?? ""
        self.fetchFavoriteMovies()
    }

    func filterUpdated(years: [Int], genreIds: [Int]) {
        self.currentYearsFilter = years
        self.currentGenreIdsFilter = genreIds
        self.fetchFavoriteMovies()
        self.checkFilters()
    }

    func deleteFavoriteTrigger(_ movie: Movie) {
        self.interactor.removeMovieFavorite(movie)
    }

    func removeFiltersTapped() {
        self.currentYearsFilter = []
        self.currentGenreIdsFilter = []
        self.checkFilters()
        self.fetchFavoriteMovies()
    }

}

// MARK: - FavoriteMoviesPresenterToInteractor

extension FavoriteMoviesPresenter: FavoriteMoviesPresenterToInteractor {

    func didFetchFavoriteMovies(_ movies: [Movie]) {
        self.view.updateMovies(with: movies)
    }
}
