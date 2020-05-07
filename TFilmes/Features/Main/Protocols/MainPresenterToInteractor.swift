//
//  MainPresenterToInteractor.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

protocol MainPresenterToInteractor: class {

    func didFetchMoviesOnApi(_ movies: [Movie])
    func didFailToFetchMovies()

}
