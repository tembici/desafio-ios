//
//  FavoritesViewController.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import UIKit

final class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTableView: UITableView!
    
    var presenter: FavoritesPresenterInput?
    
    var favoritesDisplay: [FavoriteDisplay] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        setUpTableView()
        setUpNavigation()
    }
}

extension FavoritesViewController{
    
    private func registerCell(){
        
        let nib = UINib(nibName: FavoritesTableViewCell.defaultReuseIdentifier, bundle: nil)
        favoritesTableView.register(nib, forCellReuseIdentifier: FavoritesTableViewCell.defaultReuseIdentifier)
    }
    
    private func setUpTableView(){
        
        self.favoritesTableView.delegate = self
        self.favoritesTableView.dataSource = self
    }
    
    private func setUpNavigation(){
        
        self.tabBarController?.title = "Favorites"
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension FavoritesViewController: FavoritesPresenterOutput{
    
}
