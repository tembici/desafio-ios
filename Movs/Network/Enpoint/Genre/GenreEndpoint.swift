//
//  GenreEndpoint.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

enum GenreEndpoint {
    case getGenres
}

extension GenreEndpoint: Endpoint {
    
    var baseURL: URL { return URL(string: "https://api.themoviedb.org")! }
    
    var path: String { return "/3/genre/movie/list"}
    
    var method: HTTPMethod { return .get }
    
    var headers: Headers? { return nil }
    
    var params: Params {
        return .requestParameters([
            "api_key": APIKey,
            "language": "en-US"
            ])
    }
    
    var parametersEncoding: ParametersEncoding { return .url }
    
}
