//
//  RealmDB.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import RealmSwift

final class RealmDB {

    static func configRealm() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in

                if (oldSchemaVersion < 1) {
                    migration.enumerateObjects(
                        ofType: FavoriteMovieModel.className()
                    ) { oldObject, newObject in

                        guard let releaseDateString = oldObject?["releaseDate"] as? String else { return }

                        if let releaseDate = Date(from: releaseDateString, format: "yyyy-MM-dd") {
                            newObject!["releaseDate"] = releaseDate
                        }
                    }
                }

                if (oldSchemaVersion < 2) {
                    migration.renameProperty(
                        onType: FavoriteMovieModel.className(),
                        from: "imageURL",
                        to: "imageName"
                    )
                }
        })

        Realm.Configuration.defaultConfiguration = config

        let realmDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint("Realm file directory: \(realmDirectory)")

        _ = try! Realm()
    }

}
