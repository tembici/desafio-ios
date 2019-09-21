//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    
    private var imageUrl: String = "" {
        willSet {
            let baseUrl = "https://image.tmdb.org/t/p/w500" + newValue
            self.coverImageView.cacheImage(urlString: baseUrl )
        }
    }
    
    func setup(with data: Any) {
        if let movie = data as? Movie {
            guard let imageUrl = movie.imageUrl else { return }
            self.imageUrl = imageUrl
        }
    }
}
