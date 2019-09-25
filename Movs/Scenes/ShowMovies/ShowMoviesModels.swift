//
//  ShowMoviesModels.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

enum ShowMovies {
    
    // MARK: Use cases

    enum fetchMovies {
        struct Request { }
        struct Response {
            var content: [Any]?
        }
        struct ViewModel {
             var content: [Any]
        }
    }
    
    enum favoriteMovie {
        struct Request { var movie: Movie }
        struct Response {
            var isFavorite: Bool
        }
        struct ViewModel {
            var borderColor: UIColor?
        }
    }
    
    enum queryMovies {
        struct Request { var keyword: String }
        struct Response {
            var content: [Any]?
        }
        struct ViewModel {
            var content: [Any]
        }
    }

    struct ViewParams {
        var dataPagination = 1
    }
}
