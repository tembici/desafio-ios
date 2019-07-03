//
//  FavoritesPresenter.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 03/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

protocol FavoritesPresenterProtocol {
    func present(response: FavoritesModels.FetchMovies.Response)
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    
    weak var viewController: FavoritesDisplayLogic?
    
    func present(response: FavoritesModels.FetchMovies.Response) {
        let blockForExecutionInMainThread: BlockOperation = BlockOperation(block: {
            var displayedMovies: [FavoritesModels.FetchMovies.ViewModel.DisplayedMovie] = []
            for movie in response.movies {
                guard let poster = movie.poster, let title = movie.title else { continue }
                displayedMovies.append(FavoritesModels.FetchMovies.ViewModel.DisplayedMovie(poster: poster, title: title, year: movie.releaseDate ?? "", overview: movie.overview ?? ""))
            }
            self.viewController?.display(viewModel: FavoritesModels.FetchMovies.ViewModel(displayedMovies: displayedMovies))
        })
        QueueManager.shared.executeBlock(blockForExecutionInMainThread, queueType: .main)
    }
    
}
