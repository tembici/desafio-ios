//
//  MoviesAPITypes.swift
//  Movs
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import Foundation


enum MoviesAPI: String {
    case domain     = "api.themoviedb.org"
    case discover   = "/3/discover/movie"
    case search     = "/3/search/movie"
    case detail     = "/3/movie"
    case popular    = "/3/movie/popular"
    
}
