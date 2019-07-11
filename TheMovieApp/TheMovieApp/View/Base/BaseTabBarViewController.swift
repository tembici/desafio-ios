//
//  BaseTabBarViewController.swift
//  TheMovieApp
//


import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = Colors.black
        tabBar.unselectedItemTintColor = Colors.black.withAlphaComponent(0.4)
        tabBar.barTintColor = Colors.yellow
    }
}
