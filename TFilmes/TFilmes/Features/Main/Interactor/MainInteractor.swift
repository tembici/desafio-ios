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
        guard let movies = response.results else { return }

        var mainMovies: [MainMovie] = []

        for movie in movies {
            let imageURL = self.generateImageURL(with: movie.poster_path)

            mainMovies.append(MainMovie(movieResponse: movie, imageURL: imageURL, favorite: false))
        }

        self.presenter.didFetchMoviesOnApi(mainMovies)
    }

    private func generateImageURL(with posterPath: String?) -> URL? {
        guard let posterPath = posterPath else { return nil }
        let imageBase = "https://image.tmdb.org/t/p/w185"
        return URL(string: "\(imageBase)\(posterPath)")
    }

}

// MARK: - MainInteractorToPresenter

extension MainInteractor: MainInteractorToPresenter {

    func fetchMoviesOnApi(with page: Int) {
        guard var urlComponenet = URLComponents(string: "\(self.urlString)\(self.urlPath)") else { return }

        urlComponenet.queryItems = [
            URLQueryItem(name: "api_key", value: "38187d3597431e7cbcc9a5985aacf2cc"),
            URLQueryItem(name: "page", value: String(page))
        ]

        guard let url = urlComponenet.url else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
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


        }.resume()
    }

    func updateFavoriteState(of mainMovie: MainMovie) {
        if mainMovie.favorite {
            // Create in DB
        } else {
            // Remove from DB
        }
    }
}
