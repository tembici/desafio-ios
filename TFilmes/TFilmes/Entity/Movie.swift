//
//  Movie.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

struct Movie {

    let id: Int
    let overview: String
    let releaseDate: String?
    let genreIds: [Int]
    let originalTitle: String
    let imageURL: URL?
    var favorite: Bool

    init(movieResponse: MovieResponse, imageURL: URL?, favorite: Bool) {
        self.id = movieResponse.id
        self.overview = movieResponse.overview
        self.releaseDate = movieResponse.release_date
        self.genreIds = movieResponse.genre_ids
        self.originalTitle = movieResponse.original_title

        self.imageURL = imageURL
        self.favorite = favorite
    }

}
