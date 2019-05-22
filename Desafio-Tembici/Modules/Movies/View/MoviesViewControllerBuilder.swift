//
//  MoviesViewControllerBuilder.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import UIKit

final class MoviesViewControllerBuilder{
    
    static func make(wireframe: MoviesWireframe) -> MoviesViewController{
        
        let viewController = MoviesViewController(nibName: String(describing: MoviesViewController.self), bundle: nil)
        let presenter = MoviesPresenterBuilder.make(wireframe: wireframe)
        
        viewController.presenter = presenter
        presenter.output = viewController
        
        viewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), selectedImage: UIImage(named: "list_icon"))
        
        return viewController
    }
}
