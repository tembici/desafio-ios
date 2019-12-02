//
//  MoviesServices.swift
//  Movs
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import Foundation
import Alamofire

class MoviesServices {
    
    let infoDictionary = Bundle.main.infoDictionary
    
    func popular(page number: Int? = 1, completionHandler: @escaping (String?, Error?) -> Void) {
        
        let queryItems = [NSURLQueryItem(name: "language", value: "pt-BR"), NSURLQueryItem(name: "api_key", value: infoDictionary?["TheMovieDBApiKey"] as? String), NSURLQueryItem(name: "page", value: "\(number!)") ]

        var components: URLComponents = URLComponents()
        components.scheme = "https"
        components.host = MoviesAPI.domain.rawValue
        components.path = MoviesAPI.popular.rawValue
        components.queryItems = queryItems as [URLQueryItem]
        
        Alamofire.request(components.url!, method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                
                var resultData = ""
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) { resultData = utf8Text }
                
                switch response.result {
                case .success:
                    completionHandler(resultData, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
    
    func search(query string: String, page number: Int, completionHandler: @escaping (String?, Error?) -> Void) {
        let queryItems = [NSURLQueryItem(name: "api_key", value: infoDictionary?["TheMovieDBApiKey"] as? String), NSURLQueryItem(name: "page", value: String(number)), NSURLQueryItem(name: "language", value: "pt-BR"), NSURLQueryItem(name: "include_adult", value: "false"), NSURLQueryItem(name: "query", value: string)  ]
        
        var components: URLComponents = URLComponents()
        components.scheme = "https"
        components.host = MoviesAPI.domain.rawValue
        components.path = MoviesAPI.search.rawValue
        components.queryItems = queryItems as [URLQueryItem]
        
        Alamofire.request(components.url!, method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                
                var resultData = ""
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) { resultData = utf8Text }
                
                switch response.result {
                case .success:
                    completionHandler(resultData, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
    
    func details(movie id: String, completionHandler: @escaping (String?, Error?) -> Void) {
        
        let queryItems = [NSURLQueryItem(name: "language", value: "pt-BR"),NSURLQueryItem(name: "api_key", value: infoDictionary?["TheMovieDBApiKey"] as? String)]
        
        var components: URLComponents = URLComponents()
        components.scheme = "https"
        components.host = MoviesAPI.domain.rawValue
        components.path = "\(MoviesAPI.detail.rawValue)/\(id)"
        components.queryItems = queryItems as [URLQueryItem]
        
        Alamofire.request(components.url!, method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                
                var resultData = ""
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) { resultData = utf8Text }
                
                switch response.result {
                case .success:
                    completionHandler(resultData, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
}
