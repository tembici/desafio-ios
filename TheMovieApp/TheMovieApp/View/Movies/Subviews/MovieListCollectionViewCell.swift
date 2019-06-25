//
//  MovieListCollectionViewCell.swift
//  TheMovieApp
//
//  Created by Wilson Kim on 24/06/19.
//  Copyright © 2019 WilsonKim. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieListCellDelegate {
    func didFavoriteMovie(_ cell: MovieListCollectionViewCell)
}

class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var favoriteButton: FavoriteButton!
    @IBOutlet private weak var labelContainer: UIView!
    
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
        labelContainer.backgroundColor = Colors.darkGray
    }
    
    private func setupBorder() {
        layer.borderWidth = 0.5
        layer.borderColor = Colors.darkGray.cgColor
    }
    
    public func setMovieCell(_ movie:MovieViewModel) {
        movieNameLabel.text = movie.title
//        https://image.tmdb.org/t/p/w300/j3w3lT3ABvJsVE3byNOMCYmnGMB.jpg
        let size = 300
        let imageId = movie.posterPath
        let stringUrl = "https://image.tmdb.org/t/p/w\(size)\(imageId)"
        let url = URL(string: stringUrl);
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: size, height: size), mode: .aspectFit);
        mainImageView.kf.setImage(with: url,
                                  placeholder: UIImage(named: "image_placeholder"),
                                  options: [.processor(processor)])
//        mainImageView.kf.setImage(with: url,
//                                  placeholder: UIImage(named: "image_placeholder"),
//                                  options: [.processor(processor)],
//                                  progressBlock: nil,
//                                  completionHandler:   nil);
    }
}
