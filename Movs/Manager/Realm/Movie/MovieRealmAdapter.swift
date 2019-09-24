//
//  MovieRealmAdapter.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import RealmSwift

protocol MovieAdapter {
    func getAll() -> [Movie]?
    func get(identifier: Int) -> Movie?
    func insertAndUpdate(movie: Movie) -> Movie?
    func delete(identifier: Int) -> Movie?
}

class MovieRealmAdapter: MovieAdapter {
    
    func getAll() -> [Movie]? {
        let realm = try! Realm()
        var moviesRealm = [MovieRealm]()
        let results = realm.objects(MovieRealm.self)
        moviesRealm = Array(results)
        
        return self.getMovies(by: moviesRealm)
    }
    
    func get(identifier: Int) -> Movie? {
        var movie: Movie?
        let realm = try! Realm()
        if let movieRealm = realm.objects(MovieRealm.self).filter("id = \(identifier)").first {
            movie = self.getMovie(by: movieRealm)
        }
        
        return movie
    }
    
    func insertAndUpdate(movie: Movie) -> Movie? {
        let realm = try! Realm()
        let movieRealm = self.getMovieRealm(by: movie)
        var insertedMovie: Movie? = nil
        
        try! realm.write {
            realm.add(movieRealm, update: .modified)
            insertedMovie = movie
        }
        
        return insertedMovie
    }
    
    func delete(identifier: Int) -> Movie? { return nil }
    
    // MARK: Private Methods
    
    private func getMovie(by movieRealm: MovieRealm) -> Movie {
        return Movie(id: movieRealm.id,
                     imageUrl: movieRealm.imageUrl,
                     posterImageUrl: movieRealm.posterUrl,
                     title: movieRealm.title,
                     overview: movieRealm.overview,
                     release: movieRealm.releaseYear,
                     rate: Double(movieRealm.rate ?? "0.0"),
                     genres: nil,
                     language: movieRealm.language,
                     movieLength: movieRealm.lenght,
                     isFavorite: Movie.IsFavorite(rawValue: movieRealm.isFavorite ?? ""),
                     category: Movie.Category(rawValue: movieRealm.category ?? "popular") ?? Movie.Category.popular)
    }
    
    private func getMovieRealm(by movie: Movie) -> MovieRealm {
        let movieRealm = MovieRealm()
        movieRealm.id = movie.id
        movieRealm.title = movie.title
        movieRealm.imageUrl = movie.imageUrl
        movieRealm.posterUrl = movie.posterImageUrl
        movieRealm.rate = String(describing: movie.rate)
        movieRealm.overview = movie.overview
        movieRealm.language = movie.language
        movieRealm.releaseYear = movie.release
        movieRealm.lenght = movie.movieLength ?? 0
        movieRealm.isFavorite = movie.isFavorite?.rawValue
        movieRealm.category =  movie.category.rawValue
        
        return movieRealm
    }
    
    private func getMovies(by realmMovies: [MovieRealm]) -> [Movie] {
        var movies = [Movie]()
        for realmMovie in realmMovies {
            movies.append(getMovie(by: realmMovie))
        }
        
        return movies
    }
}
