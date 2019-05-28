//
//  MovieDetailController.swift
//  MyMovieDB
//
//  Created by Chrystian Salgado on 28/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {
    
    @IBOutlet weak var contentView: MovieDetailContentView!
    
    var movie: MovieResult?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        title = movie?.title ?? NSLocalizedString("MOVIE_DETAIL_TITLE", comment: "")
        contentView.displayUI(movie: movie)
    }
}
