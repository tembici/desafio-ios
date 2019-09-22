//
//  VideosResponse.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

struct VideosResponse: Decodable {
    
    var results: [Video]
}
