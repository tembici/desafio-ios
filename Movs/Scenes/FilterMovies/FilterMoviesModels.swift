//
//  SearchMoviesModels.swift
//  Movs
//
//  Created by Miguel Pimentel on 24/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

enum FilterMovies {
    
    // MARK: Use cases

    enum FilterByGenre {
        struct Request {
            var genreId: Int
            var page: Int = 1
        }
        struct Response {
            var content: [Any]?
        }
        struct ViewModel {
            var content: [Any]
        }
    }
    
    enum FetchGenders {
        struct Request { }
        struct Response {
            var content: [Any]?
        }
        struct ViewModel {
            var content: [Any]
        }
    }
    
    enum ViewController {
        struct Params {
            var section: Int
            var page: Int
            var genderId: Int
            var title = "Categories"
        }
    }
}
