//
//  FavoriteMoviesPresenterToView.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

protocol FavoriteMoviesPresenterToView: class {

    var yearsFilter: [Int] { get }
    var genreIdsFilter: [Int] { get }

    func viewDidAppear()
    func filterMovies(with searchQuery: String?)
    func filterUpdated(years: [Int], genreIds: [Int])
    func deleteFavoriteTrigger(_ movie: Movie)
    func removeFiltersTapped()

}
