//
//  MoviesInteractor.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

protocol MoviesInteractorProtocol {
    func fetch(request: MoviesModels.FetchMovies.Request)
}

protocol MoviesDataStore {
    var movies: [Movie] { get }
}

class MoviesInteractor: MoviesInteractorProtocol, MoviesDataStore {
    
    var presenter: MoviesPresenterProtocol?
    private var moviesWorker: MoviesWorker = MoviesWorker(moviesStore: MoviesAPI())
    
    private var page: Int = 1
    var movies: [Movie] = []
    
    private let lock: NSLock = NSLock()
    private var isFetchingNextPage: Bool = false
    
    // the next two functions guarantee we have only one fetching per time
    private func shouldStartFetching() -> Bool {
        self.lock.lock()
        defer { self.lock.unlock() }
        if self.isFetchingNextPage { return false }
        self.isFetchingNextPage = true
        return true
    }
    
    private func fetchingStopped() {
        self.lock.lock()
        self.isFetchingNextPage = false
        self.lock.unlock()
    }
    
    func fetch(request: MoviesModels.FetchMovies.Request) {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            guard request.index > self.movies.count - 20 else { return }
            guard self.shouldStartFetching() else { return }
            do {
                let movies = try self.moviesWorker.fetch(page: self.page)
                self.movies.append(contentsOf: movies)
                self.page += 1
                self.presenter?.present(response: MoviesModels.FetchMovies.Response(movies: movies))
            } catch {
                debugPrint(error)
            }
            self.fetchingStopped()
            
        })
        QueueManager.shared.executeBlock(blockForExecutionInBackground, queueType: .concurrent)
    }
    
}
