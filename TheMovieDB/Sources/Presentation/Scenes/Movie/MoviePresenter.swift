//
//  MoviePresenter.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol MoviePresenterProtocol {
    func present(response: MovieModels.GetMovie.Response)
    func present(response: MovieModels.GetFavorited.Response)
    func present(response: MovieModels.ToggleFavorite.Response)
    
}

class MoviePresenter: MoviePresenterProtocol {
    
    weak var viewController: MovieDisplayLogic?
    
    func present(response: MovieModels.GetMovie.Response) {
        let blockForExecutionInMainThread: BlockOperation = BlockOperation(block: {
            let displayedMovie = MovieModels.GetMovie.ViewModel.DisplayedMovie(title: response.movie.title ?? "", year: response.movie.releaseDate ?? "", genre: response.movie.genre ?? "", description: response.movie.overview ?? "", poster: response.movie.poster ?? "")
            let viewModel = MovieModels.GetMovie.ViewModel(displayedMovie: displayedMovie)
            self.viewController?.display(viewModel: viewModel)
        })
        QueueManager.shared.executeBlock(blockForExecutionInMainThread, queueType: .main)
    }
    
    func present(response: MovieModels.GetFavorited.Response) {
        let blockForExecutionInMainThread: BlockOperation = BlockOperation(block: {
            let viewModel = MovieModels.GetFavorited.ViewModel(favorited: response.favorited ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon"))
            self.viewController?.display(viewModel: viewModel)
        })
        QueueManager.shared.executeBlock(blockForExecutionInMainThread, queueType: .main)
    }
    
    func present(response: MovieModels.ToggleFavorite.Response) {
        let blockForExecutionInMainThread: BlockOperation = BlockOperation(block: {
            let displayedFavoritedIcon = response.isFavorited ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon")
            let viewModel = MovieModels.ToggleFavorite.ViewModel(displayedFavorited: displayedFavoritedIcon)
            self.viewController?.display(viewModel: viewModel)
        })
        QueueManager.shared.executeBlock(blockForExecutionInMainThread, queueType: .main)
    }
    
}
