//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by Wilson Kim on 26/06/19.
//  Copyright © 2019 WilsonKim. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    var movie:MovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGenres()
        setupLabels()
    }
    
    private func getGenres() {
        let provider = AppProvider()
        showLoadingInView(withMessage: "Carregando informações do filme...")
        provider.makeRequest(.getGenreList, returnClass: GeneralGenreResponseModel.self, successCompletion: { (response) in
            self.setGenreText(response.getGenreModels())
            self.setNormalLayout()
        }) { (error) in
            self.showError(error)
        }
    }
    
    private func setGenreText(_ genres:[GenreModel]) {
        var genreDict:[Int:String] = [:]
        for genre in genres {
            genreDict[genre.id] = genre.name
        }

        genresLabel.text = movie!.genresIds.compactMap { (id) -> String? in
            if let str = genreDict[id] {
                return str
            }
            return nil
            }.joined(separator: ", ")
    }
    
    private func setupLabels() {
        if let movie = movie {
            title = movie.title
            mainImageView.loadImageFrom(path: movie.posterPath)
            movieTitleLabel.text = movie.title
            releaseDateLabel.text = "Premiere: \(movie.releaseDate.getYearValue())"
            movieOverviewLabel.text = movie.overview
        }
    }
}
