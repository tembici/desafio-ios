//
//  GenreRealm.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import RealmSwift

class GenreRealm: Object {
    
    @objc dynamic var id: Int = 0 /// Primary Key
    @objc dynamic var name: String = ""
    override static func primaryKey() -> String? { return "id" }
}

