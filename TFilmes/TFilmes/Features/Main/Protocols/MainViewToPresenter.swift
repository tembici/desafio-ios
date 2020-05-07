//
//  MainViewToPresenter.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

protocol MainViewToPresenter: class {

    func updateMovies(with movies: [Movie])
    func removeMovies()
    func showErrorState()

}
