//
//  TabBarViewControllerBuilder.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import UIKit

final class TabBarControllerBuilder{
    
    static func make() -> UITabBarController{
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [MoviesWireframe().getViewController(), FavoritesWireframe().getViewController()]
        tabBarController.tabBar.barTintColor = UIColor.primaryColor
        
        return tabBarController
    }
}
