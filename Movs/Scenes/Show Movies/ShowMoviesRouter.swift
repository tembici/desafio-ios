//
//  ShowMoviesRouter.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

@objc protocol ShowMoviesRoutingLogic {
    func routeToMovieDetail(movieId: Int)
}

protocol ShowMoviesDataPassing {
    var dataStore: ShowMoviesDataStore? { get }
}

class ShowMoviesRouter: NSObject, ShowMoviesRoutingLogic, ShowMoviesDataPassing {
  
    weak var viewController: ShowMoviesViewController?
    var dataStore: ShowMoviesDataStore?
    
    func routeToMovieDetail(movieId: Int) {
        let destinationVC = MovieDetailViewController()
        guard var destinationDS = destinationVC.router?.dataStore else { return }
        passDataToMovieDetail(movieId: movieId, destination: &destinationDS)
        navigateToMovieDetail(source: viewController, destination: destinationVC)
    }

    // MARK: Navigation
    
    private func navigateToMovieDetail(source: ShowMoviesViewController?, destination: MovieDetailViewController) {
        if let sourceVC = source  {
            sourceVC.show(destination, sender: nil)
        }
    }

    // MARK: Passing data
    
    private func passDataToMovieDetail(movieId: Int, destination: inout MovieDetailDataStore) {
        destination.movieId = movieId
    }
}

