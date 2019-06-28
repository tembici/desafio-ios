//
//  FavoriteMoviesViewController.swift
//  TheMovieApp
//
//  Created by Wilson Kim on 28/06/19.
//  Copyright © 2019 WilsonKim. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let coreDataManager = CoreDataManager()
        coreDataManager.getFavoriteMovies()
    }
}
