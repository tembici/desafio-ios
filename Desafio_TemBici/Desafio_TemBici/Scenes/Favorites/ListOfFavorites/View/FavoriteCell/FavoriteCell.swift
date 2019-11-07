//
//  FavoriteCell.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    //MARK: OUTLETS
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteName: UILabel!
    @IBOutlet weak var favoriteDate: UILabel!
    @IBOutlet weak var favoriteOverview: UILabel!
    
    //MARK: PROPERTIES
    var favoriteModel: FavoriteModel? {
        didSet {
            guard let favoriteModel = favoriteModel else { return }
            favoriteImage.image = favoriteModel.movieImage
            favoriteName.text = favoriteModel.movieName
            favoriteDate.text = favoriteModel.getDate()
            favoriteOverview.text = favoriteModel.movieOverview
        }
    }

}
