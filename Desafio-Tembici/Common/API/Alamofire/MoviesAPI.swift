//
//  MoviesAPI.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

final class MoviesAPI{
    
    var baseURL = "https://api.themoviedb.org/3/movie/popular?api_key="
    var apiKey = "223471d411d21bbb112ad7721e5e5c2b"

    func getMovies(completion: @escaping (([MovieAPIModel])->())){
        
        let url = baseURL+apiKey
        
        request(url){(json) in
            
            guard let _json = json, let movies = Mapper<MovieAPIModel>().mapArray(JSONObject: _json["results"]) else{
                completion([])
                return
            }
            
            completion(movies)
        }
    }
    
    func getMovie(){
        
    }
    
    private func request(_ url: String, completion: @escaping ([String: Any]?) -> ()){
        
        let _ = Alamofire.request(VPURL(urlString: url), method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
            
            completion(response.result.value as? [String : Any])
        })
    }
}
