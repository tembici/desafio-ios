//
//  FavoritesInteractor.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 03/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

protocol FavoritesInteractorProtocol {
    func fetch(request: FavoritesModels.FetchMovies.Request)
    func unfavorite(request: FavoritesModels.UnfavoriteMovie.Request)
}

protocol FavoritesDataStore {
    var movies: [Movie] { get }
}

class FavoritesInteractor: FavoritesInteractorProtocol, FavoritesDataStore {
    
    var presenter: FavoritesPresenterProtocol?
    private var movieWorkerProtocol: MovieWorkerProtocol = MovieCoreDataWorker()
    
    var movies: [Movie] = []
    
    func fetch(request: FavoritesModels.FetchMovies.Request) {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            self.movies = try! self.movieWorkerProtocol.fetch(favorited: true)
            self.presenter?.present(response: FavoritesModels.FetchMovies.Response(movies: self.movies))
        })
        QueueManager.shared.executeBlock(blockForExecutionInBackground, queueType: .concurrent)
    }
    
    func unfavorite(request: FavoritesModels.UnfavoriteMovie.Request) {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            let movie = self.movies.remove(at: request.index)
            movie.favorited = false
        })
        QueueManager.shared.executeBlock(blockForExecutionInBackground, queueType: .concurrent)
    }
    
}
