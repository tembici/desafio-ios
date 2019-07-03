//
//  FavoriteCell.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 03/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let name = String(describing: FavoriteCell.self)
    
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var overviewLabel: UILabel!
    @IBOutlet private var yearLabel: UILabel!
    
    func prepare(viewModel: FavoritesModels.FetchMovies.ViewModel.DisplayedMovie) {
        self.titleLabel.text = viewModel.title
        self.overviewLabel.text = viewModel.overview
        self.yearLabel.text = viewModel.year
        Media.download(path: viewModel.poster, imageView: self.posterImageView)
    }
    
}
