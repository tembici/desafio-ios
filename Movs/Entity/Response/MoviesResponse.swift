//
//  MoviesResponse.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

struct MoviesResponse: Decodable {
    
    var results: [Movie]
}
