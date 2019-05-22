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
        
//        self.presenter?.viewDidLoad()
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
        
        return favoritesDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! FavoritesTableViewCell
        cell.display = favoritesDisplay[indexPath.row]
        cell.configure()
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension FavoritesViewController: FavoritesPresenterOutput{
    
    func loadUIFavoriteMovies(display: [FavoriteDisplay]) {
        
        self.favoritesDisplay = display
        favoritesTableView.reloadData()
    }
}
