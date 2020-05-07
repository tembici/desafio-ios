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

    private func parsePopularMoviesResponse(_ response: PopularMovieResponse) {
        guard let moviesResponse = response.results else { return }

        var movies: [Movie] = []

        for movieResponse in moviesResponse {
            let imageURL = API.instance.generateImageURL(path: movieResponse.poster_path)

            let favorite = FavoriteMovieModel.getBy(id: movieResponse.id) != nil

            movies.append(Movie(movieResponse: movieResponse, imageURL: imageURL, favorite: favorite))
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
    
        API.instance.get(path: self.urlPath, query: query) { [weak self] (data, _, error) in
            if let error = error {
                debugPrint(error)
                self?.presenter.didFailToFetchMovies()
                return
            }

            guard let data = data else {
                self?.presenter.didFailToFetchMovies()
                return
            }

            do {
                let res = try JSONDecoder().decode(PopularMovieResponse.self, from: data)
                self?.parsePopularMoviesResponse(res)
            } catch let error {
                debugPrint(error)
                self?.presenter.didFailToFetchMovies()
            }
        }
    }

    func updateFavoriteState(of movie: Movie) {
        if movie.favorite {
            let imageName = MovieLocalImage.save(imageData: movie.image?.pngData(), imageURL: movie.imageURL)
            FavoriteMovieModel.create(
                id: movie.id,
                originalTitle: movie.originalTitle,
                overview: movie.overview,
                releaseDate: movie.releaseDate,
                imageName: imageName,
                genreIds: movie.genreIds
            )
        } else {
            MovieLocalImage.delete(imageURL: movie.imageURL)
            FavoriteMovieModel.deleteBy(id: movie.id)
        }
    }
}
