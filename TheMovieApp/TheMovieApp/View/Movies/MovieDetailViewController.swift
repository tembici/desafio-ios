//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by Wilson Kim on 26/06/19.
//  Copyright © 2019 WilsonKim. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    var movie:MovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie?.title
        mainImageView.loadImageFrom(path: movie?.posterPath ?? "")
    }
}
