//
//  MoviesResponse.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 27/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation

struct MoviesReponse: Decodable {
    var results: [MovieResult] = []
}

struct MovieResult: Decodable {
    var id: Int = 0
    var title: String = ""
    var poster_path: String = ""
}
