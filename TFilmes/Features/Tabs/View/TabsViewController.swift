//
//  TabsViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

class TabsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mainTitle = NSLocalizedString("tabs.movies", comment: "Movies tab")
        let tabBarOne = UITabBarItem(
            title: mainTitle,
            image: UIImage(systemName: "square.grid.2x2"),
            tag: 0
        )

        tabBarOne.accessibilityLabel = "Movies Button"
        self.viewControllers?[0].tabBarItem = tabBarOne

        let favoritesTitle = NSLocalizedString("tabs.favorites", comment: "Favorites tab")
        let tabBarTwo = UITabBarItem(
            title: favoritesTitle,
            image: UIImage(systemName: "heart"),
            tag: 1
        )

        tabBarTwo.accessibilityLabel = "Favorites Button"
        self.viewControllers?[1].tabBarItem = tabBarTwo
    }

}
