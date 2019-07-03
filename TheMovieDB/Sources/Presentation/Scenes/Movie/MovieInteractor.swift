//
//  MovieInteractor.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

protocol MovieInteractorProtocol {
    func get(request: MovieModels.GetMovie.Request)
    func favorite(request: MovieModels.ToggleFavorite.Request)
}

protocol MovieDataStore {
    var movie: Movie? { get set }
}

class MovieInteractor: MovieInteractorProtocol, MovieDataStore {
    
    var presenter: MoviePresenterProtocol?
    var movie: Movie?
    
    private var movieWorkerProtocol: MovieWorkerProtocol = MovieCoreDataWorker()
    
    func get(request: MovieModels.GetMovie.Request) {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            guard let movie = self.movie else { return }
            self.presenter?.present(response: MovieModels.GetMovie.Response(movie: movie))
        })
        QueueManager.shared.executeBlock(blockForExecutionInBackground, queueType: .concurrent)
    }
    
    func favorite(request: MovieModels.ToggleFavorite.Request) {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            guard let movie = self.movie else { return }
            movie.favorited.toggle()
            
            if movie.favorited {
                try! self.movieWorkerProtocol.create(movie)
            } else {
                try! self.movieWorkerProtocol.delete(movie)
            }
            self.presenter?.present(response: MovieModels.ToggleFavorite.Response(isFavorited: movie.favorited))
        })
        QueueManager.shared.executeBlock(blockForExecutionInBackground, queueType: .concurrent)
    }
    
}
