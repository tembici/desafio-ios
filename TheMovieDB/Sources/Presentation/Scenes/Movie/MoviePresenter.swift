//
//  MoviePresenter.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

protocol MoviePresenterProtocol {
    func present(response: MovieModels.GetMovie.Response)
}

class MoviePresenter: MoviePresenterProtocol {
    
    weak var viewController: MovieDisplayLogic?
    
    func present(response: MovieModels.GetMovie.Response) {
        let blockForExecutionInMainThread: BlockOperation = BlockOperation(block: {
            let displayedMovie = MovieModels.GetMovie.ViewModel.DisplayedMovie(title: response.movie.title ?? "", year: response.movie.releaseDate ?? "", genre: response.movie.genre ?? "", description: response.movie.overview ?? "")
            let viewModel = MovieModels.GetMovie.ViewModel(displayedMovie: displayedMovie)
            self.viewController?.display(viewModel: viewModel)
        })
        QueueManager.shared.executeBlock(blockForExecutionInMainThread, queueType: .main)
    }
    
}
