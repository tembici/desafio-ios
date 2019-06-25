//
//  MovieListCollectionViewCell.swift
//  TheMovieApp
//
//  Created by Wilson Kim on 24/06/19.
//  Copyright © 2019 WilsonKim. All rights reserved.
//

import UIKit

protocol MovieListCellDelegate {
    func didFavoriteMovie(_ cell: MovieListCollectionViewCell)
}

class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: FavoriteButton!
    
    var delegate:MovieListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLabel()
        setupBorder()
    }

    @IBAction func favoriteMovieButtonClicked(_ sender: Any) {
        self.delegate?.didFavoriteMovie(self)
    }
    
    private func setupLabel() {
        movieNameLabel.textColor = Colors.yellow
    }
    
    private func setupBorder() {
        layer.borderWidth = 0.5
        layer.borderColor = Colors.darkGray.cgColor
    }
}
