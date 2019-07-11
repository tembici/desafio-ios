//
//  BaseNavigationViewController.swift
//  TheMovieApp
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = Colors.yellow
        self.navigationBar.tintColor = Colors.marineBlue
        self.navigationBar.isTranslucent = true
    }
}
