//
//  MainPresenterToView.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

protocol MainPresenterToView {

    func viewDidLoad()
    func fetchMoreMovies()
    func filterMainMovies(with query: String?)
    func favoriteChanged(mainMovie: MainMovie)

}
