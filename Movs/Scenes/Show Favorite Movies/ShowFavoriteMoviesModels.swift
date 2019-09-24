//
//  ShowFavoriteMoviesModels.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

enum ShowFavoriteMovies {
    
    // MARK: Use cases

    enum FetchFavoriteMovies {
        struct Request { }
        struct Response {
            var content: [Any]?
        }
        struct ViewModel {
            var content: [Any]
        }
    }
    
    enum UnfavoriteMovie {
        struct Request {
            var movie: Movie
        }
        struct Response {
            var content: [Any]?
        }
        struct ViewModel {
            var content: [Any]
        }
    }
}
