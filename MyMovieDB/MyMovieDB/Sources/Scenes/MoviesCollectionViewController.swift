//
//  MainViewController.swift
//  MyMovieDB
//
//  Created by Chrystian Salgado on 24/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController, MovieCollectionViewDelegate {
    
    private let cellIdentifier = "moveisCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        requestMovies()
    }
    
    private func requestMovies() {
        // ...
    }

    private func configureUI() {
        self.title = NSLocalizedString("MOVIES_TITLE", comment: "")
    }
    
    func handlerActionFavorite() {
        print("pass")
    }
}

extension MoviesCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MoviesCollectionViewCell
        collectionViewCell.cellDelegate = self
        collectionViewCell.displayUI()
        
        return collectionViewCell
    }
}

extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let internalSpacing: CGFloat = 16
        let externalSpacing: CGFloat = 16 * 2 // (left and right spacing)
        let width: CGFloat = (collectionView.frame.width - internalSpacing - externalSpacing ) / 2
        let height: CGFloat = 230.0
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

