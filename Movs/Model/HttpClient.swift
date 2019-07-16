//
//  HttpClient.swift
//  Movs
//
//  Created by Ivan Ortiz on 15/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import Foundation
import Alamofire

struct URLMovs {
    static var url = "https://api.themoviedb.org/3"
}

struct HttpClient {
    static var shared = HttpClient()
    private init() { }
    private var API_KEY = "cf49c46bacede05058a4fda7a5124dec"
    func getMoviesList(completion: @escaping (MoviesData?,Error?) -> ()) {
        let parameters = ["api_key": API_KEY]
        let url = URLMovs.url + "/movie/popular"
        let headers: HTTPHeaders = [
            "Content-type": "application/json"
        ]
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseMoviesList{ response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let data = response.result.value {
                completion(data, nil)
                return
            }
        }
    }
    // MARK: - LOGIN
    func getGenreList(completion: @escaping (GenresData?,Error?) -> ()) {

        let parameters = ["api_key": API_KEY]
        let url = URLMovs.url + "/genre/movie/list"
        let headers: HTTPHeaders = [
            "Content-type": "application/json"
        ]
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseGenreList{ response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let data = response.result.value {
                completion(data, nil)
                return
            }
        }
    }
}
