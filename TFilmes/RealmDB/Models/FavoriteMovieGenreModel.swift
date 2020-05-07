//
//  FavoriteMovieGenreModel.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import RealmSwift

class FavoriteMovieGenreModel: Object {

    @objc dynamic var movieId: Int = 0
    @objc dynamic var genreId: Int = 0

    var movie: FavoriteMovieModel? {
        FavoriteMovieModel.getBy(id: self.movieId)
    }

    var genre: GenreModel? {
        GenreModel.getBy(id: self.genreId)
    }

    static func create(
        movieId: Int,
        genreId: Int
    ) {
        let favoriteMovieGenreModel = FavoriteMovieGenreModel()
        favoriteMovieGenreModel.movieId = movieId
        favoriteMovieGenreModel.genreId = genreId

        let realm = try! Realm()
        try! realm.write {
            realm.add(favoriteMovieGenreModel)
        }
    }

    static func getAll(WithMovieId movieId: Int) -> [FavoriteMovieGenreModel] {
        return try! Realm()
            .objects(FavoriteMovieGenreModel.self)
            .filter("movieId == \(movieId)")
            .compactMap { $0 }
    }

    static func getMoviesIds(ofGenreIds genreIds: [Int]) -> Set<Int> {
        let query = NSPredicate(format: "genreId IN %@", genreIds)

        let moviesId = try! Realm()
            .objects(FavoriteMovieGenreModel.self)
            .filter(query)
            .compactMap { $0.movieId }

        return Set(moviesId)
    }

    static func deleteAll(ofMovieId movieId: Int) {
        let movieGenres = try! Realm()
            .objects(FavoriteMovieGenreModel.self)
            .filter("movieId == \(movieId)")

        let realm = try! Realm()
        try! realm.write {
            realm.delete(movieGenres)
        }
    }

}
