//
//  MovieDetailController.swift
//  MyMovieDB
//
//  Created by Chrystian Salgado on 28/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit
import JGProgressHUD

class MovieDetailController: UIViewController {
    
    @IBOutlet weak var contentView: MovieDetailContentView!
    
    var movie: MovieResult?
    private let loadingView: JGProgressHUD = JGProgressHUD(style: .light)

    override func viewDidLoad() {
        super.viewDidLoad()
        requestMovieDetail()
    }
    
    private func requestMovieDetail() {
        loadingView.show(in: self.view)
        Manager().requestDetail(param: "\(movie?.id ?? 0)"){ (movieResponse, error) in
            if let _movieResponse = movieResponse {
                self.movie = _movieResponse
            } else if let _error = error {
                self.display(errorAlert(error: _error))
            }
            self.loadingView.dismiss()
            self.configureUI()
        }
    }
    
    func display(_ alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    private func configureUI() {
        title = movie?.title ?? NSLocalizedString("MOVIE_DETAIL_TITLE", comment: "")
        contentView.displayUI(movie: movie)
    }
}
