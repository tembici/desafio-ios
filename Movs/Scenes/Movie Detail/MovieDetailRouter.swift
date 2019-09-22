//
//  MovieDetailRouter.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

import UIKit

@objc protocol MovieDetailRoutingLogic { }

protocol MovieDetailDataPassing {
    var dataStore: MovieDetailDataStore? { get set }
}

class MovieDetailRouter: NSObject, MovieDetailRoutingLogic, MovieDetailDataPassing {
    weak var viewController: MovieDetailViewController?
    var dataStore: MovieDetailDataStore?
}
