//
//  MovieAPI.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation
import Moya

enum MovieAPI {
    case popular(page:Int)
    case genre
}


extension MovieAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Constants.API.theMoviedbApiUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .genre:
            return "genre/movie/list"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .genre:
            return .requestParameters(parameters: ["api_key":  Constants.API.movieAPIKey], encoding: URLEncoding.queryString)
        case .popular(let page):
            return .requestParameters(parameters: ["page":page, "api_key": Constants.API.movieAPIKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
        
    }
}
