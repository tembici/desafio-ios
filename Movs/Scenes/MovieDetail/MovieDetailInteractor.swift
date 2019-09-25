//
//  MovieDetailInteractor.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

import UIKit

protocol MovieDetailBusinessLogic {
    func fetchMovieDetails(request: MovieDetail.FetchMovieDetails.Request)
    func fetchMovieVideos(request: MovieDetail.FetchMovieVideos.Request)
}

protocol MovieDetailDataStore {
    var movieId: Int { get set }
}

class MovieDetailInteractor: MovieDetailBusinessLogic, MovieDetailDataStore {
    
    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorker?
    var movieId: Int = 0
    
    // MARK: - Business Logic -
    
    func fetchMovieDetails(request: MovieDetail.FetchMovieDetails.Request) {
        worker = MovieDetailWorker()
        worker?.getMovieDetails(movieId: request.movieId) { movie in
            let response = MovieDetail.FetchMovieDetails.Response(movie: movie)
            self.presenter?.presentMovieDetails(response: response)
        }
    }
    
    func fetchMovieVideos(request: MovieDetail.FetchMovieVideos.Request) {
        worker = MovieDetailWorker()
        worker?.getVideos(movieId: request.movieId) { videos in
            let response = MovieDetail.FetchMovieVideos.Response(content: videos)
            self.presenter?.presentMovieVideos(response: response)
        }
    }
}
