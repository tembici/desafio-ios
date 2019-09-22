//
//  MovieDetailWorker.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit


    
class MovieDetailWorker {
    
    private let networkManager = NetworkManager()

    func getMovieDetails(movieId: Int, completion: @escaping (Movie?)-> Void) {
        networkManager.request(type: Movie.self,
                               service: MovieEndpoint.getMovieDetail(id: movieId)) { response in
            switch response {
                case let .success(movie):
                    completion(movie)
                case .failure(_):
                    completion(nil)
            }
        }
    }
    
    func getVideos(movieId: Int, completion: @escaping ([Video]?) -> Void) {
        networkManager.request(type: VideosResponse.self,
                               service: MovieEndpoint.getVideos(id: movieId)) { response in
            switch response {
                case let .success(result):
                    completion(result.results)
                case .failure(_):
                    completion(nil)
            }
        }
    }
}

