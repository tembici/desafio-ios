//
//  MoviesWorker.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

class MoviesWorker {
    
    private(set) var moviesStore: MoviesStoreProtocol
    
    init(moviesStore: MoviesStoreProtocol) {
        self.moviesStore = moviesStore
    }
    
    func fetch(page: Int) throws -> [Movie] {
        return try self.moviesStore.fetchPopular()(page)
    }
    
}

// MARK: - Server List API

protocol MoviesStoreProtocol {
    func fetchPopular() -> ((_ page: Int) throws -> [Movie])
}
