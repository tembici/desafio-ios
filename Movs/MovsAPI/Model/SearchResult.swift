//
//  SearchResult.swift
//  BuscaFilmes
//
//  Created by Elias Amigo on 12/03/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import Foundation

struct SearchResult {
    var itemId: String
    var releaseDate: String
    var originalTitle: String
    var posterPath: String
    var overview: String
    
    init(itemId: String? = nil, releaseDate: String? = nil, originalTitle: String? = nil, posterPath: String? = nil, overview: String? = nil) {
        self.itemId = itemId!
        self.releaseDate = releaseDate!
        self.originalTitle = originalTitle!
        self.posterPath = posterPath!
        self.overview = overview!
    }
}
