//
//  MainPresenterToView.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

protocol MainPresenterToView: class {

    func viewDidLoad()
    func fetchMoreMovies()
    func filterMovies(with query: String?)
    func favoriteChanged(movie: Movie, imageData: Data?)
    func tryToGetMoviesTapped()

}
