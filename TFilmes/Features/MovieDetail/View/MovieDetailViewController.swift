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

    weak var delegate: MovieDetailDelegate?
    var movieToShow: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateImage()
        self.updateFavoriteColor()

        self.titleLabel.text = self.movieToShow?.originalTitle
        if let releaseData = self.movieToShow?.releaseDate {
            self.yearLabel.text = String(releaseData.getYear())
        } else {
            self.yearLabel.text = ""
        }

        let genres = self.movieToShow?.genres
            .description
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
            .replacingOccurrences(of: "\"", with: "")

        self.genresLabel.text = genres
        self.overviewLabel.text = self.movieToShow?.overview
    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let movie = self.movieToShow else { return }
        movie.favorite = !movie.favorite
        self.movieToShow = movie

        self.updateFavoriteColor()
        self.presenter.favoriteButtonTapped()

        self.delegate?.favoriteChanged(movie: movie)
    }

    private func updateFavoriteColor() {
        if self.movieToShow?.favorite ?? false {
            self.favoriteButton.tintColor = CollorPallet.primary
        } else {
            self.favoriteButton.tintColor = CollorPallet.gray
        }
    }

    private func updateImage() {
        if let image = self.movieToShow?.image {
            self.imageView.image = image
        } else {
            self.imageView.showAnimatedGradientSkeleton()
            self.movieToShow?.getImage { image in
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                    self?.imageView.hideSkeleton()
                }
            }
        }
    }
}

// MARK: - MovieDetailViewToPresenter

extension MovieDetailViewController: MovieDetailViewToPresenter {

    var movie: Movie? {
        self.movieToShow
    }

}
