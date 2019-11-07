//
//  Endpoint.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 06/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import Foundation

public enum MoviesEndpoint {
    case popular(page: Int)
    case detail(id: Int)
}

extension MoviesEndpoint: EndPointType {
    
    var environmentBaseURL : String {
        return "https://api.themoviedb.org/3/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .detail(let id):
            return "movie/\(id)"
        }
    }
        
    var httpMethod: HTTPMethod {
        switch self {
        case .popular:
            return .get
        case .detail:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .popular(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page": page,
                                                      "api_key": Key.MovieAPIKey])
        case .detail(let id):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["movie_id": id,
                                                      "api_key": Key.MovieAPIKey])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
        
}
