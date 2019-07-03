//
//  FavoritesRouter.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 03/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation
import UIKit.UIStoryboardSegue

@objc
protocol FavoritesRouting: class {
    func routeToShowDetail(segue: UIStoryboardSegue, sender: Any?)
}

protocol FavoritesRouterProtocol: NSObjectProtocol {
    var dataStore: FavoritesDataStore? { get }
}

class FavoritesRouter: NSObject, FavoritesRouterProtocol, FavoritesRouting {
    
    var dataStore: FavoritesDataStore?
    
    func routeToShowDetail(segue: UIStoryboardSegue, sender: Any?) {
        guard let dataStore = self.dataStore else {
            return
        }
        
        // self.passDataTo*(source: dataStore, destination: &destinationDS, sender: sender)
    }
    
    // MARK: Passing data
    
    // private func passDataToShowDetail(source: ServerListDataStore, destination: inout [Destination]DataStore, sender: Any?) {
    //     guard let item: Int = sender as? Int else { return }
    //     destination.photo = source.photos[item]
    // }

}
