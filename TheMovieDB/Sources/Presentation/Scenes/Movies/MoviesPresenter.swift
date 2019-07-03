//
//  MoviesPresenter.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

protocol MoviesPresenterProtocol {
    func present(response: MoviesModels.FetchMovies.Response)
    func present(response: MoviesModels.Update.Response)
}

class MoviesPresenter: MoviesPresenterProtocol {
    
    weak var viewController: MoviesDisplayLogic?
    
    func present(response: MoviesModels.FetchMovies.Response) {
        let blockForExecutionInMainThread: BlockOperation = BlockOperation(block: {
            var displayedMovies: [MoviesModels.DisplayedMovie] = []
            for movie in response.movies {
                guard let poster = movie.poster, let title = movie.title else { continue }
                displayedMovies.append(MoviesModels.DisplayedMovie(poster: poster, title: title, isFavorited: movie.favorited))
            }
            self.viewController?.display(viewModel: MoviesModels.FetchMovies.ViewModel(displayedMovies: displayedMovies))
        })
        QueueManager.shared.executeBlock(blockForExecutionInMainThread, queueType: .main)
    }
    
    func present(response: MoviesModels.Update.Response) {
        let blockForExecutionInMainThread: BlockOperation = BlockOperation(block: {
            var displayedMovies: [MoviesModels.DisplayedMovie] = []
            for movie in response.movies {
                guard let poster = movie.poster, let title = movie.title else { continue }
                displayedMovies.append(MoviesModels.DisplayedMovie(poster: poster, title: title, isFavorited: movie.favorited))
            }
            self.viewController?.display(viewModel: MoviesModels.Update.ViewModel(displayedMovies: displayedMovies))
        })
        QueueManager.shared.executeBlock(blockForExecutionInMainThread, queueType: .main)
    }
    
}
