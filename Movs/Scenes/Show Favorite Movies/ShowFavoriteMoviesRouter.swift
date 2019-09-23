//
//  ShowFavoriteMoviesRouter.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

@objc protocol ShowFavoriteMoviesRoutingLogic {
    func routeToMovieDetail(movieId: Int)
}

protocol ShowFavoriteMoviesDataPassing {
    var dataStore: ShowFavoriteMoviesDataStore? { get }
}

class ShowFavoriteMoviesRouter: NSObject, ShowFavoriteMoviesRoutingLogic, ShowFavoriteMoviesDataPassing {
    
    weak var viewController: ShowFavoriteMoviesViewController?
    var dataStore: ShowFavoriteMoviesDataStore?
    
    
    func routeToMovieDetail(movieId: Int) {
        let destinationVC = MovieDetailViewController()
        guard var destinationDS = destinationVC.router?.dataStore else { return }
        passDataToMovieDetail(movieId: movieId, destination: &destinationDS)
        navigateToMovieDetail(source: viewController, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    private func navigateToMovieDetail(source: ShowFavoriteMoviesViewController?, destination: MovieDetailViewController) {
        if let sourceVC = source  {
            sourceVC.show(destination, sender: nil)
        }
    }
    
    // MARK: Passing data
    
    private func passDataToMovieDetail(movieId: Int, destination: inout MovieDetailDataStore) {
        destination.movieId = movieId
    }
}
