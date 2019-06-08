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
    
    func handlerActionFavorite(favorite: Bool)
}

class MovieDetailContentView: UIView {
    
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblMovieGender: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    @IBOutlet weak var ivMovieBanner: UIImageView!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var delegate: MovieDetailViewDelegate?
    private var movie: MovieResult?
    
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
        self.movie = movie
        var stringDate = ""
        if let releaseDateString = movie?.releaseDate {
            stringDate = releaseDateString.toDateString(format: "yyyy")
        }
        
        lblMovieName.text = movie?.title
        lblMovieYear.text = stringDate
        lblMovieGender.text = formatGenres(genres: movie?.genres)
        lblMovieDescription.text = movie?.overview
        ivMovieBanner.image = imageHelper(posterPath: movie?.posterPath)
        btnFavorite.isSelected = movie?.favorite ?? false
    }
    
    private func formatGenres(genres: [Genres]?) -> String {
        var allGenres = ""
        if let _genres = genres, !_genres.isEmpty {
            for genre in _genres {
                if _genres.count > 1 {
                    allGenres = "\(allGenres) \(genre.name),"
                } else {
                    allGenres = "\(genre.name)"
                }
            }
        }
        return allGenres
    }
    
    @IBAction func actionFavorite(sender: Any) {
        guard let favorited = movie?.favorite else { return }
        delegate?.handlerActionFavorite(favorite: !favorited)
    }
}

fileprivate extension String {
    func toDateString(format: String) -> String {
        var date: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}
