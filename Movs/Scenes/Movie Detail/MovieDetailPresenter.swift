//
//  MovieDetailPresenter.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

import UIKit

protocol MovieDetailPresentationLogic {
    func presentMovieDetails(response: MovieDetail.FetchMovieDetails.Response)
    func presentMovieVideos(response: MovieDetail.FetchMovieVideos.Response)
}

class MovieDetailPresenter: MovieDetailPresentationLogic {
    
    weak var viewController: MovieDetailDisplayLogic?
    
    // MARK: Presentation Logic
    func presentMovieDetails(response: MovieDetail.FetchMovieDetails.Response) {
        guard let movieTitle = response.movie?.title,
            let movieRate = response.movie?.rate,
            let posterImageUrl = response.movie?.posterImageUrl,
            let stringfiedDate = response.movie?.release,
            let movieOverview = response.movie?.overview else { return }
        
        let viewModel = MovieDetail.FetchMovieDetails.ViewModel(
            movieTitle: movieTitle,
            moviePosterUrl: "https://image.tmdb.org/t/p/original\(posterImageUrl)",
            movieRate: "\(movieRate) de 10",
            movieOverview: movieOverview,
            movieReleaseYear: self.formattedDateFromString(dateString: stringfiedDate,
                                                           withFormat: "yyyy") ?? "-",
            movieLength: "\(response.movie?.movieLength ?? 0)",
            movieLanguage: response.movie?.language ?? "-")
        
        self.viewController?.displayMovieDetails(viewModel: viewModel)
    }
    
    func presentMovieVideos(response: MovieDetail.FetchMovieVideos.Response) {
        if let content = response.content {
            let viewModel = MovieDetail.FetchMovieVideos.ViewModel(content: content)
            self.viewController?.displayVideos(viewModel: viewModel)
        }
    }
    
    // MARK: Private Methods
    
    private func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormatter.Pattern.year.rawValue
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
}
