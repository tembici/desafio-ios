//
//  MoviesViewController.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var presenter: MoviesPresenter?
    
    var moviesDisplay: [MovieDisplay] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setUpNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCell()
        self.setUpNavigation()
        
        presenter?.viewDidLoad()
    }
}

extension MoviesViewController{
    
    private func registerCell(){
        
        let nib = UINib(nibName: MovieCollectionViewCell.defaultReuseIdentifier, bundle: nil)
        moviesCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.defaultReuseIdentifier)
    }
    
    private func setUpCollectionView(){
        
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
    }
    
    private func setUpNavigation(){
        
        self.tabBarController?.title = "Movies"
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.defaultReuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        let movie = moviesDisplay[indexPath.row]
        cell.movieDisplay = movie
        cell.configure()
        
        return cell
    }
}

extension MoviesViewController: MoviesPresenterOutput{
    
    func loadUIMovies(items: [MovieItem]) {
        
        for item in items{
            guard let displayItem = MovieMapper.make(from: item) else{
                return
            }
            self.moviesDisplay.append(displayItem)
        }
        self.moviesCollectionView.reloadData()
    }
}

extension MoviesViewController: MovieCollectionViewCellDelegate{
    
    func favoriteButtonClicked(id: Int) {
        
    }
    
    func didSelect(id: Int) {
        
    }
}

