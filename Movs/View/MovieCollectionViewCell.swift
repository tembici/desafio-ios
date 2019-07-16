//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Ivan Ortiz on 15/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import UIKit

protocol MovieCollectionViewCellDelegate {
    func favoritePressed(with movie:Movie?)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imvMovie: UIImageView!
    @IBOutlet weak var btnFavoriteIcon: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    var delegate: MovieCollectionViewCellDelegate?
    
    var isFavorite = false
    
    var movie : Movie?{
        didSet {
            lblTitle.text = "\(movie?.title ?? "")"
            imvMovie.imageFromUrl(movie?.poster_path ?? "", placeHolder: nil)
            loadFavoriteStatus()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func loadFavoriteStatus()
    {
        var nameImage = "favorite_gray_icon"
        if isFavorite
        {
            nameImage = "favorite_full_icon"
        }
        btnFavoriteIcon.setImage(UIImage(named: nameImage), for: UIControl.State.normal)
    }
    
    @IBAction func favoritePressed(sender:Any?)
    {
        isFavorite = !isFavorite
        loadFavoriteStatus()
        delegate?.favoritePressed(with: movie)
    }
}
