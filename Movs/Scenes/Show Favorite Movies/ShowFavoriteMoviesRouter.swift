//
//  ShowFavoriteMoviesRouter.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

@objc protocol ShowFavoriteMoviesRoutingLogic {
}

protocol ShowFavoriteMoviesDataPassing {
    var dataStore: ShowFavoriteMoviesDataStore? { get }
}

class ShowFavoriteMoviesRouter: NSObject, ShowFavoriteMoviesRoutingLogic, ShowFavoriteMoviesDataPassing {
    weak var viewController: ShowFavoriteMoviesViewController?
    var dataStore: ShowFavoriteMoviesDataStore?
}
