//
//  SearchMoviesRouter.swift
//  Movs
//
//  Created by Miguel Pimentel on 24/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

@objc protocol SearchMoviesRoutingLogic {
    func routeToMovieDetail(movieId: Int)
}

protocol SearchMoviesDataPassing {
    var dataStore: SearchMoviesDataStore? { get }
}

class FilterMoviesRouter: NSObject, SearchMoviesRoutingLogic, SearchMoviesDataPassing {
   
    weak var viewController: FilterMoviesViewController?
    var dataStore: SearchMoviesDataStore?

    // MARK: Routing
    
    func routeToMovieDetail(movieId: Int) {
        let destinationVC = MovieDetailViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMovieDetail(movieId: movieId, destination: &destinationDS)
        navigateToMovieDetail(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation
    
    private func navigateToMovieDetail(source: FilterMoviesViewController, destination: MovieDetailViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    private func passDataToMovieDetail(movieId: Int, destination: inout MovieDetailDataStore) {
        destination.movieId = movieId
    }
}
