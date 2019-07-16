//
//  FavoriteList.swift
//  Movs
//
//  Created by Ivan Ortiz on 16/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import Foundation
class FavoriteList {
    static var shared = FavoriteList()
    private init() { }
    var list = [Movie]()
    
    func favoriteHandler(with movie:Movie) {
        
        if let index = list.firstIndex(where: { $0.id == movie.id }) {
            list.remove(at: index)
        }
        else
        {
            list.append(movie)
        }
    }

}
