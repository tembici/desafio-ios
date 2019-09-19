//
//  ShowMoviesRouter.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

@objc protocol ShowMoviesRoutingLogic {
}

protocol ShowMoviesDataPassing {
    var dataStore: ShowMoviesDataStore? { get }
}

class ShowMoviesRouter: NSObject, ShowMoviesRoutingLogic, ShowMoviesDataPassing {
    weak var viewController: ShowMoviesViewController?
    var dataStore: ShowMoviesDataStore?
}
