//
//  MovieDetailViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UITableViewController {

    private lazy var presenter: MovieDetailPresenterToView = {
        return MovieDetailPresenter(view: self)
    }()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    var movieToShow: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.imageView.showAnimatedGradientSkeleton()
        self.imageView.load(url: self.movieToShow?.imageURL)
        self.titleLabel.text = self.movieToShow?.originalTitle
        self.yearLabel.text = self.movieToShow?.releaseDate
        let genres = self.movieToShow?.genres
            .description
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
            .replacingOccurrences(of: "\"", with: "")

        self.genresLabel.text = genres
        self.overviewLabel.text = self.movieToShow?.overview

        if self.movieToShow?.favorite ?? false {
            self.favoriteButton.tintColor = CollorPallet.primary
        } else {
            self.favoriteButton.tintColor = CollorPallet.gray
        }
    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
    }
}

// MARK: - MovieDetailViewToPresenter

extension MovieDetailViewController: MovieDetailViewToPresenter {

}
