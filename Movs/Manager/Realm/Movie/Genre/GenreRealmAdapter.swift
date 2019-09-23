//
//  GenreRealmAdapter.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import RealmSwift

protocol GenreAdapter {
    func insert(genre: Genre)
    func getAll() -> [Genre]?
    func get(identifier: Int) -> Genre?
    func update(genre: Genre) -> Genre?
    func delete(identifier: Int) -> Genre?
}


class GenreRealmAdapter: GenreAdapter {
    
    func insert(genre: Genre) {
        let realmGenre = self.getGenreRealm(from: genre)
        let realm = try! Realm()
        try! realm.write {
            realm.add(realmGenre, update: .modified)
        }
    }
    
    func getAll() -> [Genre]? {
        var genresRealm = [GenreRealm]()
        let realm = try! Realm()
        let results = realm.objects(GenreRealm.self)
        genresRealm = Array(results)
        
        return getGenres(by: genresRealm)
    }
    
    func get(identifier: Int) -> Genre? {
        let realm = try! Realm()
        if let genreRealm = realm.objects(GenreRealm.self).filter("id = \(identifier)").first {
            let genre = self.getGenre(by: genreRealm)
            return genre
        }
        
        return nil
    }
    
    func update(genre: Genre) -> Genre? { return nil }
    
    func delete(identifier: Int) -> Genre? { return nil }
    
    // MARK: Private Methods
    
    private func getGenreRealm(from genre: Genre) -> GenreRealm {
        let realmGenre = GenreRealm()
        realmGenre.id = genre.id
        realmGenre.name = genre.name
        
        return realmGenre
    }
    
    private func getGenres(by realmGenres: [GenreRealm]) -> [Genre] {
        var genres = [Genre]()
        for realmGenre in realmGenres {
            let genre = getGenre(by: realmGenre)
            genres.append(genre)
        }
        
        return genres
    }
    
    private func getGenre(by realmGenre: GenreRealm) -> Genre {
        return Genre(id: realmGenre.id, name: realmGenre.name)
    }
}
