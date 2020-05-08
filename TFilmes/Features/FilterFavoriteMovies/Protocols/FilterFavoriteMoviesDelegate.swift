//
//  FilterFavoriteMoviesDelegate.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

protocol FilterFavoriteMoviesDelegate: class {

    func applyFiltersTapped(years: [Int], genreIds: [Int])

}
