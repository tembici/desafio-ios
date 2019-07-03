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
    func fetch(request: MoviesModels.Update.Request)
}

protocol MoviesDataStore {
    var movies: [Movie] { get }
}

class MoviesInteractor: MoviesInteractorProtocol, MoviesDataStore {
    
    var presenter: MoviesPresenterProtocol?
    private var moviesWorker: MoviesWorker = MoviesWorker(moviesStore: MoviesAPI())
    private var movieWorkerProtocol: MovieWorkerProtocol = MovieCoreDataWorker()
    
    private var page: Int = 1
    var movies: [Movie] = []
    
    private var favoritedMovies: [Movie] = []
    private var favoritedMoviesIDs: [Int] { return self.favoritedMovies.map({ $0.id }) }
    
    private let lock: NSLock = NSLock()
    private var isFetchingNextPage: Bool = false
    
    init() {
        self.favoritedMovies = try! self.movieWorkerProtocol.fetch(favorited: true)
    }
    
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
                // fetch from API
                var movies = try self.moviesWorker.fetch(page: self.page)
                
                // for each movie, detect if we have favorited before
                for (index, movie) in movies.enumerated() where self.favoritedMoviesIDs.contains(movie.id) {
                    // if so, switch with what we have locally
                    let favoritedMovie = self.favoritedMovies.first(where: { $0.id == movie.id })
                    movies[index] = favoritedMovie!
                }
                
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
    
    func fetch(request: MoviesModels.Update.Request) {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            self.presenter?.present(response: MoviesModels.Update.Response(movies: self.movies))
        })
        QueueManager.shared.executeBlock(blockForExecutionInBackground, queueType: .concurrent)
    }
        
}
