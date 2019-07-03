//
//  FavoritesModel.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 03/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

enum FavoritesModels {
    
    enum FetchMovies {
        struct Request {
        }
        struct Response {
            let movies: [Movie]
        }
        struct ViewModel {
            struct DisplayedMovie {
                let poster: String
                let title: String
                let year: String
                let overview: String
            }
            let displayedMovies: [DisplayedMovie]
        }
    }
    
    enum UnfavoriteMovie {
        struct Request {
            let index: Int
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
}
