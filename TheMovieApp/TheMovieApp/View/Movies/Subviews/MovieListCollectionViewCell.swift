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

    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var favoriteButton: FavoriteButton!
    
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
    
    public func setMovieName(_ name:String) {
        movieNameLabel.text = name
    }
}
