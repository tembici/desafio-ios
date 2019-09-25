//
//  FavoriteMovieTableViewCell.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol FavoriteMovieTableViewCellDelegate: class {
    func didSelectFavorite(for movie: Movie?)
}
protocol FavoriteMovieTableViewCellDataStore {
    var movie: Movie? { get set }
}

class FavoriteMovieTableViewCell: UITableViewCell, FavoriteMovieTableViewCellDataStore {
    
    var delegate: FavoriteMovieTableViewCellDelegate?
    var movie: Movie?
    
    private var imageUrl: String = "" {
        willSet {
            let baseUrl = "https://image.tmdb.org/t/p/w500" + newValue
            self.movieImageView.cacheImage(urlString: baseUrl )
        }
    }

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        self.unfavoriteMovie()
        self.delegate?.didSelectFavorite(for: movie)
    }
    
   
    func setup(with data: Any, delegate: FavoriteMovieTableViewCellDelegate) {
        self.delegate = delegate
        if let movie = data as? Movie {
            self.movie = movie
            self.titleLabel.text = movie.title
            self.yearLabel.text = DateHelper.formattedDateFromString(dateString: movie.release,
                                                                     withFormat: "yyyy")
            self.imageUrl = movie.imageUrl!
        }
    }
    
    private func unfavoriteMovie() {
        self.movie?.isFavorite = Movie.IsFavorite.notFavorite
    }
}
