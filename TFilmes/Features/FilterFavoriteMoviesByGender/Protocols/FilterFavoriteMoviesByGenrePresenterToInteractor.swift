//
//  FilterFavoriteMoviesByGenrePresenterToInteractor.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 08/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

protocol FilterFavoriteMoviesByGenrePresenterToInteractor: class {

    func didFetchAllGenresInFavorite(_ genres: [GenreFilterItem])

}
