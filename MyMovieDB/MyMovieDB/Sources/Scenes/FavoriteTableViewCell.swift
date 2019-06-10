//
//  FavoriteTableViewCell.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 09/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivBannerImage: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ movie: MovieResult) {
        lblMovieName.text = movie.title
        lblMovieDescription.text = movie.overview
        
        var stringDate: String?
        if let releaseDateString = movie.releaseDate {
            stringDate = releaseDateString.toDateString(format: "yyyy")
        }
        if let _stringDate = stringDate {
            lblMovieYear.text = _stringDate
        } else {
            lblMovieYear.removeFromSuperview()
        }
        
        DispatchQueue.main.async {
            self.ivBannerImage = imageHelper(oldImageView: self.ivBannerImage, posterPath: movie.posterPath, quality: .low)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ivBannerImage.image = nil
        lblMovieName.text = ""
        lblMovieYear.text = ""
        lblMovieDescription.text = ""
    }
}
