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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        presenter?.viewDidLoad()
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
}

extension MoviesViewController: MoviesPresenterOutput{
    
    func loadUIMovies(display: [MovieItem]) {
        
    }
}

