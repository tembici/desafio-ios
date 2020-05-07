//
//  MainInteractor.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class MainInteractor {

    unowned private let presenter: MainPresenterToInteractor

    init (presenter: MainPresenterToInteractor) {
        self.presenter = presenter
    }

    private let urlPath = "/movie/popular"
    private let urlString = "https://api.themoviedb.org/3"

    private func parsePopularMoviesResponse(_ response: PopularMovieResponse) {
        guard let moviesResponse = response.results else { return }

        var movies: [Movie] = []

        for movieResponse in moviesResponse {
            let imageURL = API.instance.generateImageURL(path: movieResponse.poster_path)

            movies.append(Movie(movieResponse: movieResponse, imageURL: imageURL, favorite: false))
        }

        self.presenter.didFetchMoviesOnApi(movies)
    }

}

// MARK: - MainInteractorToPresenter

extension MainInteractor: MainInteractorToPresenter {

    func fetchMoviesOnApi(with page: Int) {
        let query = [
            URLQueryItem(name: "page", value: String(page))
        ]
    
        API.instance.get(path: self.urlPath, query: query) { (data, _, error) in
            if let error = error {
                debugPrint(error)
                return
            }

            guard let data = data else { return }

            do {
                let res = try JSONDecoder().decode(PopularMovieResponse.self, from: data)
                self.parsePopularMoviesResponse(res)
            } catch let error {
                debugPrint(error)
            }
        }
    }

    func updateFavoriteState(of movie: Movie) {
        if movie.favorite {
            // Create in DB
        } else {
            // Remove from DB
        }
    }
}
