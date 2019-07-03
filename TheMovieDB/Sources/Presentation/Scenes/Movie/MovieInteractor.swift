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
}

protocol MovieDataStore {
    var movie: Movie? { get set }
}

class MovieInteractor: MovieInteractorProtocol, MovieDataStore {
    
    var presenter: MoviePresenterProtocol?
    var movie: Movie?
    
    func get(request: MovieModels.GetMovie.Request) {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            guard let movie = self.movie else { return }
            self.presenter?.present(response: MovieModels.GetMovie.Response(movie: movie))
        })
        QueueManager.shared.executeBlock(blockForExecutionInBackground, queueType: .concurrent)
    }
    
}
