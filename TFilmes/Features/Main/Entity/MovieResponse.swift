//
//  MovieResponse.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

class MovieResponse: Codable {

    let poster_path: String?
    let overview: String
    let release_date: String?
    let genre_ids: [Int]
    let id: Int
    let original_title: String

}
