//
//  MoviesCollectionViewCell.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 26/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit

protocol MovieCollectionViewDelegate {
    func handlerActionFavorite(movie: MovieResult)
}

class MoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieBannerIv: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var cellDelegate: MovieCollectionViewDelegate?
    private var movie: MovieResult?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
    
    func displayUI(_ movie: MovieResult) {
        self.movie = movie
        btnFavorite.isSelected = movie.favorite
        lblMovieName.text = movie.title
        
        self.movieBannerIv = imageHelper(oldImageView: self.movieBannerIv, posterPath: movie.posterPath, quality: .low)
    }
    
    @IBAction func actionFavorite(_ sender: Any) {
        if movie != nil {
            btnFavorite.isSelected = !movie!.favorite
            cellDelegate?.handlerActionFavorite(movie: movie!)
        }
    }
}
