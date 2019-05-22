//
//  FavoritesViewControllerBuilder.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import UIKit

final class FavoritesViewControllerBuilder{
    
    static func make(wireframe: FavoritesWireframe) -> FavoritesViewController{
        
        let interactor = FavoritesInteractor(manager: MoviesManager())
        let presenter = FavoritesPresenter(wireframe: wireframe, interactor: interactor)
        
        let viewController = FavoritesViewController(nibName: String(describing: FavoritesViewController.self), bundle: nil)
        
        viewController.presenter = presenter
        presenter.output = viewController
        
        viewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorites_empty_icon"), selectedImage: UIImage(named: "favorites_empty_icon"))
        
        return viewController
    }
}
