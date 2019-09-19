//
//  ShowMoviesRouter.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

@objc protocol ShowMoviesRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ShowMoviesDataPassing {
    var dataStore: ShowMoviesDataStore? { get }
}

class ShowMoviesRouter: NSObject, ShowMoviesRoutingLogic, ShowMoviesDataPassing {
    weak var viewController: ShowMoviesViewController?
    var dataStore: ShowMoviesDataStore?

    // MARK: Routing

    // func routeToSomewhere(segue: UIStoryboardSegue?) {
    //     if let segue = segue {
    //         let destinationVC = segue.destination as! SomewhereViewController
    //         var destinationDS = destinationVC.router!.dataStore!
    //         passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //     } else {
    //         let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //         let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //         var destinationDS = destinationVC.router!.dataStore!
    //         passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //         navigateToSomewhere(source: viewController!, destination: destinationVC)
    //     }
    // }

    // MARK: Navigation

    // func navigateToSomewhere(source: ShowMoviesViewController, destination: SomewhereViewController) {
    //     source.show(destination, sender: nil)
    // }

    // MARK: Passing data

    // func passDataToSomewhere(source: ShowMoviesDataStore, destination: inout SomewhereDataStore) {
    //     destination.name = source.name
    // }
}
