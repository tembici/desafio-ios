//
//  Services.swift
//  movie
//
//  Created by ely.assumpcao.ndiaye on 23/05/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class MovieServices {
    
    static let instance = MovieServices()
    
    var movies = [Movies]()
    
    func findAllMovies( completion: @escaping CompletionHandler) {
        //["\(BASE_URL)/\(user)/repos"]
        Alamofire.request(BASE_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            print(response.result)
            if response.result.error == nil {
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    json["results"].array?.forEach({(item)in
                        let id = item["id"].stringValue
                        let title = item["title"].stringValue
                        let poster_path = item["poster_path"].stringValue
                        let release_date = item["release_date"].stringValue
                        var genre_ids = item["genre_ids"][0].stringValue
                        let overview = item["overview"].stringValue
                        
                        switch(genre_ids){
                        case ("28"):
                            genre_ids = "Action"
                        case ("12"):
                            genre_ids = "Adventure"
                        case ("16"):
                            genre_ids = "Animation"
                        case ("35"):
                            genre_ids = "Comedy"
                        case ("80"):
                            genre_ids = "Crime"
                        case ("99"):
                            genre_ids = "Documentary"
                        case ("18"):
                            genre_ids = "Drama"
                        case ("10751"):
                            genre_ids = "Family"
                        case ("14"):
                            genre_ids = "Fantasy"
                        case ("36"):
                            genre_ids = "History"
                        case ("27"):
                            genre_ids = "Horror"
                        case ("10402"):
                            genre_ids = "Music"
                        case ("9648"):
                            genre_ids = "Mystery"
                        case ("10749"):
                            genre_ids = "Romance"
                        case ("878"):
                            genre_ids = "Science Fiction"
                        case ("10752"):
                            genre_ids = "War"
                        default:
                            genre_ids = "Unknow"
                        }
                   
                        let movie = Movies(id: id, title: title, poster_path: poster_path, release_date: release_date, genre_ids: genre_ids, overview: overview)
                        self.movies.append(movie)
                    })
                    completion(true, "OK")
                case .failure( _):
                    print(response.result.error as Any)
                    debugPrint(response.result.error as Any)
                    completion(false, "Movie not found. Please enter another name.")
                } // Switcase
            }// response resultt
            else {
                if let error = response.result.error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                    completion(false, "A network error has occurred. Check your Internet connection and try again later.")
                    print(error)
                }//error COnnection
                completion(false, "Search not found. Please enter another search")
                print(response.response?.statusCode as Any)
                debugPrint(response.result.error as Any)
            }
        }// alamo.request
    }//findAllSearchs
    
    func findSearchMovies(query: String, completion: @escaping CompletionHandler) {
        //"\(BASE_URL_SEARCH)\(query)\(REST_URL_SEARCH)"
        Alamofire.request("\(SEARCH_URL)\(query)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            print(response.result)
            if response.result.error == nil {
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    json["results"].array?.forEach({(item)in
                        let id = item["id"].stringValue
                        let title = item["title"].stringValue
                        let poster_path = item["poster_path"].stringValue
                        let release_date = item["release_date"].stringValue
                        var genre_ids = item["genre_ids"][0].stringValue
                        let overview = item["overview"].stringValue
                        
                        switch(genre_ids){
                        case ("28"):
                            genre_ids = "Action"
                        case ("12"):
                            genre_ids = "Adventure"
                        case ("16"):
                            genre_ids = "Animation"
                        case ("35"):
                            genre_ids = "Comedy"
                        case ("80"):
                            genre_ids = "Crime"
                        case ("99"):
                            genre_ids = "Documentary"
                        case ("18"):
                            genre_ids = "Drama"
                        case ("10751"):
                            genre_ids = "Family"
                        case ("14"):
                            genre_ids = "Fantasy"
                        case ("36"):
                            genre_ids = "History"
                        case ("27"):
                            genre_ids = "Horror"
                        case ("10402"):
                            genre_ids = "Music"
                        case ("9648"):
                            genre_ids = "Mystery"
                        case ("10749"):
                            genre_ids = "Romance"
                        case ("878"):
                            genre_ids = "Science Fiction"
                        case ("10752"):
                            genre_ids = "War"
                        default:
                            genre_ids = "Unknow"
                        }
                        
                        let movie = Movies(id: id, title: title, poster_path: poster_path, release_date: release_date, genre_ids: genre_ids, overview: overview)
                        self.movies.append(movie)
                        print(title)
                    })
                    completion(true, "OK")
                case .failure( _):
                    print(response.result.error as Any)
                    debugPrint(response.result.error as Any)
                    completion(false, "Movie not found. Please enter another name.")
                }
            }
            else {
                if let error = response.result.error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                    completion(false, "A network error has occurred. Check your Internet connection and try again later.")
                    print(error)
                }
                completion(false, "Search not found. Please enter another search")
                print(response.response?.statusCode as Any)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearMovie() {
        movies.removeAll()
    }
    
}
