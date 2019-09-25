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
    func routeToFilterMovies()
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
        self.passDataToMovieDetail(movieId: movieId, destination: &destinationDS)
        self.navigateToMovieDetail(source: self.viewController, destination: destinationVC)
    }
    
    func routeToFilterMovies() {
        let destinationVC = FilterMoviesViewController()
        self.navigateToFilterMovies(source: self.viewController, destination: destinationVC)
    }

    // MARK: - Navigation
    
    private func navigateToMovieDetail(source: ShowMoviesViewController?,
                                       destination: MovieDetailViewController) {
        if let sourceVC = source {
            sourceVC.show(destination, sender: nil)
        }
    }
    
    private func navigateToFilterMovies(source: ShowMoviesViewController?,
                                        destination: FilterMoviesViewController) {
        if let sourceVC = source {
            sourceVC.show(destination, sender: nil)
        }
    }

    // MARK: - Passing data
    
    private func passDataToMovieDetail(movieId: Int, destination: inout MovieDetailDataStore) {
        destination.movieId = movieId
    }
}

