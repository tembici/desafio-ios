//
//  MoviesAPI.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

class MoviesAPI: API, MoviesStoreProtocol {
    
    func fetchPopular() -> ((_ page: Int) throws -> [Movie]) {
        return { page in
            struct Movies: Codable {
                let results: [Movie]
            }
            let movies: Movies = try API.request(request: Request.get(domain: "https://api.themoviedb.org/3/", endpoint: "movie/popular", parameters: ["page": "\(page)"]))
            return movies.results
        }
    }
    
}
