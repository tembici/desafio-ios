//
//  MovieCollectionViewCell.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit
import SkeletonView

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    private var movie: Movie?

    weak var delegate: MovieColletionViewCellDelegate?

    func updateData(with movie: Movie) {
        self.movie = movie

        self.titleLabel.text = movie.originalTitle
        self.updateImage()
        self.updateFavoriteColor()
    }

    @IBAction func favoriteTapped(_ sender: Any) {
        guard let movie = self.movie else { return }
        movie.favorite = !movie.favorite
        self.movie = movie

        self.updateFavoriteColor()

        self.delegate?.favoriteButtonTapped(movie: movie)
    }

    private func updateImage() {
        if let image = self.movie?.image {
            self.imageView.image = image
        } else {
            self.imageView.showAnimatedGradientSkeleton()
            self.movie?.getImage { image in
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                    self?.imageView.hideSkeleton()
                }
            }
        }
    }

    private func updateFavoriteColor() {
        if self.movie?.favorite ?? false {
            self.favoriteButton.tintColor = CollorPallet.primary
        } else {
            self.favoriteButton.tintColor = CollorPallet.gray
        }
    }

}
