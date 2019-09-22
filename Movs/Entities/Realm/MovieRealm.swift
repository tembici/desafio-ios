//
//  MovieRealm.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import RealmSwift

class MovieRealm: Object {
    
    @objc dynamic var id: Int = 0 /// Primary Key
    
    @objc dynamic var title: String?
    @objc dynamic var imageUrl: String?
    @objc dynamic var posterUrl: String?
    @objc dynamic var rate: String? = nil
    @objc dynamic var overview: String? = nil
    @objc dynamic var language: String? = nil
    @objc dynamic var releaseYear: String? = nil
    @objc dynamic var category: String? = nil
    @objc dynamic var lenght: Int = 0
    
    dynamic var isFavorite: Bool = false
    
    override static func primaryKey() -> String? { return "id" }
}
