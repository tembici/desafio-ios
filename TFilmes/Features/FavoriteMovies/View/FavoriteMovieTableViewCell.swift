//
//  FavoriteMovieTableViewCell.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    private var movie: Movie?

    func updateCell(with movie: Movie) {
        self.movie = movie
        self.titleLabel.text = movie.originalTitle
        self.movieImageView.image = movie.image

        if let releaseData = movie.releaseDate {
            self.yearLabel.text = String(releaseData.getYear())
        } else {
            self.yearLabel.text = ""
        }

        self.overviewLabel.text = movie.overview
    }
    
}
