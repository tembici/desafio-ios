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

class FavoriteMovieTableViewCell: UITableViewCell {
    
    var delegate: FavoriteMovieTableViewCellDelegate?

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    private var imageUrl: String = "" {
        willSet {
            let baseUrl = "https://image.tmdb.org/t/p/w500" + newValue
            self.movieImageView.cacheImage(urlString: baseUrl )
        }
    }
    
    
    func setup(with data: Any, delegate: FavoriteMovieTableViewCellDelegate) {
        self.delegate = delegate
        if let movie = data as? Movie {
            self.titleLabel.text = movie.title
            self.yearLabel.text = self.formattedDateFromString(dateString: movie.release,
                                                               withFormat: "yyyy")
            self.imageUrl = movie.imageUrl!
        }
    }
    
    private func formattedDateFromString(dateString: String?, withFormat format: String) -> String? {
        guard let dateStringfied = dateString else { return nil }
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormatter.Pattern.year.rawValue
        
        if let date = inputFormatter.date(from: dateStringfied) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
}
