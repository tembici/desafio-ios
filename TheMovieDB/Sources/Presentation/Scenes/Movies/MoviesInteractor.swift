//
//  MoviesInteractor.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

protocol MoviesInteractorProtocol {
    func didLoad()
}

protocol MoviesDataStore {
    
}

class MoviesInteractor: MoviesInteractorProtocol, MoviesDataStore {
    
    var presenter: MoviesPresenterProtocol?
    private var moviesWorker: MoviesWorker = MoviesWorker(moviesStore: MoviesAPI())
    
    private var page: Int = 1
    private var movies: [Movie] = []
    
    func didLoad() {
        self.fetchNextPage()
    }
    
    private func fetchNextPage() {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            do {
                let movies = try self.moviesWorker.fetch(page: self.page)
                self.page += 1
                self.presenter?.present(response: Movies.FetchMovies.Response(movies: movies))
            } catch {
                debugPrint(error)
            }
        })
        QueueManager.shared.executeBlock(blockForExecutionInBackground, queueType: .serial)
    }
    
}
