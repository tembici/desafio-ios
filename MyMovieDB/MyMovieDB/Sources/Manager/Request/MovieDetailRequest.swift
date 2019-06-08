//
//  MovieDetailRequest.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 07/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation

struct MovieDetailRequest: Encodable {
    var api_key: String? = "e1694c199ec268346e637bc040fad518"
//    var movie_id: String = ""
    var language: String = "en-US"
    
//    init(movieId: Int) {
//        self.movie_id = "\(movieId)"
//    }
}
