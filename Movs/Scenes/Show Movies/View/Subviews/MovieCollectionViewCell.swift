//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol MovieCollectionViewCellDelegate: class {
    func didSelectFavorite(for movie: Movie?)
}

protocol MovieCollectionViewCellDataStore {
    var movie: Movie? { get set }
}

class MovieCollectionViewCell: UICollectionViewCell, MovieCollectionViewCellDataStore {

    var delegate: MovieCollectionViewCellDelegate?
    var movie: Movie? = nil
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        delegate?.didSelectFavorite(for: self.movie)
    }
    
    private var imageUrl: String = "" {
        willSet {
            let baseUrl = "https://image.tmdb.org/t/p/w500" + newValue
            self.coverImageView.cacheImage(urlString: baseUrl )
        }
    }
    
    private var isFavorite: Bool = false {
        willSet {
            if newValue {
                self.layer.borderColor = UIColor.black.cgColor
                self.layer.borderWidth = 10
            }
        }
    }
    
    func setup(with data: Any, delegate: MovieCollectionViewCellDelegate) {
        if let movie = data as? Movie {
            self.delegate = delegate
            self.movie = movie
            guard let imageUrl = movie.imageUrl else { return }
            self.imageUrl = imageUrl
            self.isFavorite = movie.isFavorite ?? false
        }
    }
}

