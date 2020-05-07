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
        self.viewControllers?[0].tabBarItem = UITabBarItem(
            title: mainTitle,
            image: UIImage(systemName: "square.grid.2x2"),
            tag: 0
        )

        let favoritesTitle = NSLocalizedString("tabs.favorites", comment: "Favorites tab")
        self.viewControllers?[1].tabBarItem = UITabBarItem(
            title: favoritesTitle,
            image: UIImage(systemName: "heart"),
            tag: 1
        )
    }

}
