 //
//  MovieCell.swift
//  movie
//
//  Created by ely.assumpcao.ndiaye on 22/05/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit
 import CoreData

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLbl: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
      var status = false
    
    func configureCell(movie : Movies) {
        let MovieTitle = movie.title ?? ""
        movieLbl.text = MovieTitle
        
        let pathImage = String(movie.poster_path) ?? ""
        let Image = "\(URL_IMG)\(pathImage)" ?? ""
        let url = URL(string: Image)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            movieImage.image = UIImage(data: imageData)
        }
        
    }//ConfigureCell
    
}
