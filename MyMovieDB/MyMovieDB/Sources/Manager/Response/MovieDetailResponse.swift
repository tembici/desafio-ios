//
//  MovieDetailResponse.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 07/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation

struct MovieDetailResponse {
    var genres: [Genres] = []
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}

extension MovieDetailResponse: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        genres = try values.decode([Genres].self, forKey: .genres)
    }
}


struct Genres: Decodable {
    var id: Int = 0
    var name: String = "Action"
}
