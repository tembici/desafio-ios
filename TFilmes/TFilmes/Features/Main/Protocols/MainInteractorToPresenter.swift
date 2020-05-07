//
//  MainInteractorToPresenter.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

protocol MainInteractorToPresenter: class {

    func fetchMoviesOnApi(with page: Int)
    func updateFavoriteState(of movie: Movie)

}
