//
//  FavoriteTableViewCell.swift
//  Movs
//
//  Created by Ivan Ortiz on 16/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import UIKit

protocol FavoriteTableViewCellDelegate {
//    func favoritePressed(with movie:Movie?)
}

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imvMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var delegate: MovieCollectionViewCellDelegate?
    
    var isFavorite = false
    
    var movie : Movie?{
        didSet {
            lblTitle.text = "\(movie?.title ?? "")"
            lblDescription.text = "\(movie?.overview ?? "")"
            imvMovie.imageFromUrl(movie?.poster_path ?? "", placeHolder: nil)
            lblYear.text = movie?.release_date?.year ?? ""
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

