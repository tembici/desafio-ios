// 
//  ListOfFavoritesController.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class ListOfFavoritesController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: PROPERTIES
    lazy var activityIndicatorView = UIActivityIndicatorView(style: .large)
    lazy var searchController = UISearchController(searchResultsController: nil)
    lazy var presenter: ListOfFavoritesPresenter = {
        let p = ListOfFavoritesPresenter(view: self, router: ListOfFavoritesRouter(self))
        return p
    }()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.viewDidAppear()
    }
    
    //MARK: NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(segue: segue, sender: sender)
    }
    
}

//MARK: ListOfFavoritesView
extension ListOfFavoritesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteCell
        
        presenter.configure(cell, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.delete(row: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

// MARK: UISearchResultsUpdating
extension ListOfFavoritesController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            presenter.filtered(text)
        }
    }
    
}

//MARK: ListOfFavoritesView
extension ListOfFavoritesController: ListOfFavoritesView {
    
    func configureUI() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        searchController.searchBar.tintColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicatorView.color = #colorLiteral(red: 0.9690945745, green: 0.8084867597, blue: 0.3556014299, alpha: 1)
            self?.activityIndicatorView.startAnimating()
            self?.activityIndicatorView.isHidden = false
            self?.tableView.backgroundView = self?.activityIndicatorView
        }
    }

    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicatorView.stopAnimating()
            self?.activityIndicatorView.isHidden = true
            self?.tableView.backgroundView = nil
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func tableViewIsHidden() {
        tableView.isHidden = true
        errorView.isHidden = false
    }
    
    func tableViewNotHidden() {
        tableView.isHidden = false
        errorView.isHidden = true
    }
    
    func display(message: String) {
        errorLbl.text = message
    }
    
}
