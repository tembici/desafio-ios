//
//  ShowMoviesWorker.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

class ShowMoviesWorker {

    private let networkManager = NetworkManager()
    private let movieManager = MovieManager()
    
    func getMovies(for page: Int, completion: @escaping ([Movie]?) -> Void) {
        networkManager.request(type: MoviesResponse.self,
                               service: MovieEndpoint.getMovies(category: .popular, page: 1)) { response in
            switch response {
                case .success(let result):
                    _ = self.movieManager.insertMany(movies: result.results)
                    completion(result.results)
                case .failure:
                    let movies = self.movieManager.getAll()
                    completion(movies)
            }
        }
    }
}
