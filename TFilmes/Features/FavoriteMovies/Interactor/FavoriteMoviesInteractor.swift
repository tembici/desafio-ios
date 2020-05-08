//
//  FavoriteMoviesInteractor.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation
import RealmSwift

final class FavoriteMoviesInteractor {

    unowned private let presenter: FavoriteMoviesPresenterToInteractor

    init (presenter: FavoriteMoviesPresenterToInteractor) {
        self.presenter = presenter
    }

}

// MARK: - FavoriteMoviesInteractorToPresenter

extension FavoriteMoviesInteractor: FavoriteMoviesInteractorToPresenter {

    func fetchFavoriteMovies(
        withSearchQuery searchQuery: String?,
        inYears years: [Int]?,
        inGenreIds genreIds: [Int]?
    ) {

        var realmResults = try! Realm()
            .objects(FavoriteMovieModel.self)

        if let searchQuery = searchQuery {
            realmResults = realmResults.filter("originalTitle LIKE '*\(searchQuery)*'")
        }

        if let genreIds = genreIds, !genreIds.isEmpty {
            let movieIds = FavoriteMovieGenreModel.getMoviesIds(ofGenreIds: genreIds)
            let query = NSPredicate(format: "id IN %@", Array(movieIds))
            realmResults = realmResults.filter(query)
        }

        let favoriteMovies: [FavoriteMovieModel] = realmResults.sorted(byKeyPath: "originalTitle").compactMap {
            guard let years = years, !years.isEmpty else { return $0 }
            guard let movieYear = $0.releaseDate?.getYear() else { return nil }
            return years.contains(movieYear) ? $0 : nil

        }

        var movies: [Movie] = []
        for favoriteMovie in favoriteMovies {
            let movie = Movie(favoriteMovieModel: favoriteMovie)

            movies.append(movie)
        }

        self.presenter.didFetchFavoriteMovies(movies)
    }

}
