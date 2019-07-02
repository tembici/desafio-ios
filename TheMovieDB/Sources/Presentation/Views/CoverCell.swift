//
//  CoverCell.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import UIKit

class CoverCell: UICollectionViewCell {
    
    static let name = String(describing: CoverCell.self)
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    
    func prepare(viewModel: Movies.FetchMovies.ViewModel.DisplayedMovie) {
        self.titleLabel.text = viewModel.title
        Media.download(path: viewModel.poster, imageView: self.imageView)
    }
    
}
