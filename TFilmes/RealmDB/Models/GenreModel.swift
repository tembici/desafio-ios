//
//  GenreModel.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

import RealmSwift

class GenreModel: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""

    static func getAll() -> [GenreModel] {
        return try! Realm()
            .objects(GenreModel.self)
            .compactMap { $0 }
    }

    static func create(
        id: Int,
        name: String
    ) {
        let genreModel = GenreModel()
        genreModel.id = id
        genreModel.name = name

        let realm = try! Realm()
        try! realm.write {
            realm.add(genreModel)
        }
    }

    static func getBy(id: Int) -> GenreModel? {
        return try! Realm()
            .objects(GenreModel.self)
            .filter("id == \(id)")
            .first
    }

    static func find(byIdIn ids: [Int]) -> [GenreModel] {
        let query = NSPredicate(format: "id IN %@", ids)

        return try! Realm()
            .objects(GenreModel.self)
            .filter(query)
            .compactMap { $0 }
    }

}
