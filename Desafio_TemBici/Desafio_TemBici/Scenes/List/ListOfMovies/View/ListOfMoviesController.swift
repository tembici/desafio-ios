// 
//  ListOfMoviesController.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class ListOfMoviesController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: PROPERTIES
    lazy var activityIndicatorView = UIActivityIndicatorView(style: .large)
    lazy var searchController = UISearchController(searchResultsController: nil)
    lazy var presenter: ListOfMoviesPresenter = {
        let p = ListOfMoviesPresenter(view: self, router: ListOfMoviesRouter(self))
        return p
    }()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    //MARK: NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(segue: segue, sender: sender)
    }
    
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ListOfMoviesController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! ListCell
        
        presenter.configure(cell, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        presenter.getMoreMovies(for: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        presenter.didSelect(index: indexPath.row)
    }
    
}

extension ListOfMoviesController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.bounds.width / 2, height: 270)
    }
    
}

// MARK: UISearchResultsUpdating
extension ListOfMoviesController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            presenter.filtered(text)
        }
    }
    
}

//MARK: ListOfMoviesView
extension ListOfMoviesController: ListOfMoviesView {
    
    func error(message: String) {
        
    }
    
    func collectionIsHidden() {
        collectionView.isHidden = true
    }
    
    func collectionNotHidden() {
        collectionView.isHidden = false
    }
    
    func removeBlackSpace() {
        guard let navigationController = navigationController else { return }
        navigationController.view.backgroundColor = .white
    }
    
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
            self?.collectionView.backgroundView = self?.activityIndicatorView
        }
    }

    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicatorView.stopAnimating()
            self?.activityIndicatorView.isHidden = true
            self?.collectionView.backgroundView = nil
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}
