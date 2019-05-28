//
//  MovieDetailContentView.swift
//  MyMovieDB
//
//  Created by Chrystian Salgado on 28/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailViewDelegate {
    
    func handlerActionFavorite()
}

class MovieDetailContentView: UIView {
    
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblMovieGender: UILabel!
    @IBOutlet weak var ivMovieBanner: UIImageView!
    
    var delegate: MovieDetailViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func displayUI(movie: MovieResult?) {
        lblMovieName.text = movie?.title
        lblMovieYear.text = "2009"
        lblMovieGender.text = "Some"
        ivMovieBanner.image = UIImage(contentsOfFile: "")
    }
    
    @IBAction func actionFavorite(sender: Any) {
        delegate?.handlerActionFavorite()
    }
}
