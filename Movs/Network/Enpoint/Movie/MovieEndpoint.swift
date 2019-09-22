//
//  MovieEndpoint.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

enum MovieEndpoint {
    case getMovieDetail(id: Int)
    case getByGenre(genreId: Int, page: Int)
    case getVideos(id: Int)
    case getMovies(category: Movie.Category, page: Int)
}

extension MovieEndpoint: Endpoint {
    
    var baseURL: URL { return URL(string: "https://api.themoviedb.org")! }
    
    var path: String {
        switch self {
            case .getMovieDetail(let id):
                return "/3/movie/\(id)"
            case .getByGenre:
                return "/3/discover/movie"
            case .getVideos(let id):
                return "/3/movie/\(id)/videos"
            case .getMovies(let category, _):
                return "/3/movie/\(category.rawValue)"
        }
    }
    
    var method: HTTPMethod { return .get }
    
    var headers: Headers? { return nil }
    
    var params: Params {
        switch self {
            case .getByGenre(let genreId, let page):
                return self.getMovieByGenre(genreId: genreId, page: page)
            case .getMovieDetail:
                return self.getParametersGetGenre()
            case .getMovies(_ , let page):
                return self.getParameters(for: page)
            default:
                return self.getParameters()
        }
    }
    
    var parametersEncoding: ParametersEncoding { return .url }
    
    private func getParameters(for page: Int = 1) -> Params {
        return .requestParameters([
            "api_key": APIKey,
            "language": "en-US",
            "page": "\(page)"
            ])
    }
    
    private func getParametersGetGenre() -> Params {
        return .requestParameters([
            "api_key": APIKey,
            "language": "en-US"
            ])
    }
    
    private func getMovieByGenre(genreId: Int, page: Int) -> Params {
        return .requestParameters([
            "api_key": APIKey,
            "with_genres": "\(genreId)",
            "page": "\(page)"
            ])
    }
}
