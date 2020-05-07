//
//  FavoriteMovieModel.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import RealmSwift

class FavoriteMovieModel: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: String?
    @objc dynamic var imageURL: String?

    var genres: [GenreModel] {
        return FavoriteMovieGenreModel.getAll(WithMovieId: self.id).compactMap { $0.genre }
    }

    static func create(
        id: Int,
        overview: String,
        releaseDate: String?,
        imageURL: String?,
        genreIds: [Int]
    ) {
        let favoriteMovieModel = FavoriteMovieModel()
        favoriteMovieModel.id = id
        favoriteMovieModel.overview = overview
        favoriteMovieModel.releaseDate = releaseDate
        favoriteMovieModel.imageURL = imageURL

        let realm = try! Realm()
        try! realm.write {
            realm.add(favoriteMovieModel)
        }

        for genreId in genreIds {
            FavoriteMovieGenreModel.create(movieId: id, genreId: genreId)
        }
    }

    static func getAll() -> [FavoriteMovieModel] {
        return try! Realm()
            .objects(FavoriteMovieModel.self)
            .compactMap { $0 }
    }

    static func getBy(id: Int) -> FavoriteMovieModel? {
        return try! Realm()
            .objects(FavoriteMovieModel.self)
            .filter("id == \(id)")
            .first
    }

    static func getAll(withGenreIdsIn genreIds: [Int]) -> [FavoriteMovieModel] {
        let movieIds = FavoriteMovieGenreModel.getMoviesIds(ofGenreIds: genreIds)

        let query = NSPredicate(format: "id in %@", Array(movieIds).realmQuery)

        return try! Realm()
            .objects(FavoriteMovieModel.self)
            .filter(query)
            .compactMap { $0 }
    }

    static func deleteBy(id: Int) {
        if let movie = FavoriteMovieModel.getBy(id: id) {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(movie)
            }
        }

        FavoriteMovieGenreModel.deleteAll(ofMovieId: id)
    }

}
