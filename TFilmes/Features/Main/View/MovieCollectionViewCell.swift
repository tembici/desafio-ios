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
        self.imageView.showAnimatedGradientSkeleton()
        self.imageView.load(url: movie.imageURL)

        if movie.favorite {
            self.favoriteButton.tintColor = UIColor.yellow
        } else {
            self.favoriteButton.tintColor = UIColor.gray
        }
    }

    @IBAction func favoriteTapped(_ sender: Any) {
        guard var movie = self.movie else { return }
        movie.favorite = !movie.favorite
        self.movie = movie

        if movie.favorite {
            self.favoriteButton.tintColor = CollorPallet.primary
        } else {
            self.favoriteButton.tintColor = CollorPallet.gray
        }

        self.delegate?.favoriteChanged(movie: movie, imageData: self.imageView.image?.pngData())
    }

}
