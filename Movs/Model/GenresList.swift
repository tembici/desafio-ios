//
//  GenresList.swift
//  Movs
//
//  Created by Ivan Ortiz on 16/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import Foundation
class GenresList {
    static var shared = GenresList()
    private init() {}
    var list = [Genre]()
}
