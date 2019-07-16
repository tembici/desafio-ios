//
//  Movie.swift
//  Movs
//
//  Created by Ivan Ortiz on 15/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import Foundation
import Alamofire

struct MoviesData: Codable {
    var results: [Movie]
}

struct Movie: Codable{
    var vote_count: Int?
    var id: Int?
    var video: Bool?
    var vote_average:Float?
    var title: String?
    var popularity: Double?
    var poster_path: String?
    var original_language: String?
    var original_title: String?
    var genre_ids: [Int]?
    var backdrop_path:String?
    var adult:Bool?
    var overview: String?
    var release_date: String?
}

struct GenresData: Codable {
    var genres: [Genre]
}

struct Genre: Codable {
    var id:Int?
    var name:String?
}

extension DataRequest {
    @discardableResult
    func responseMoviesList(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<MoviesData>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

extension DataRequest {
    @discardableResult
    func responseGenreList(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GenresData>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

//{
//    "vote_count": 1644,
//    "id": 429617,
//    "video": false,
//    "vote_average": 7.8,
//    "title": "Spider-Man: Far from Home",
//    "popularity": 529.965,
//    "poster_path": "/rjbNpRMoVvqHmhmksbokcyCr7wn.jpg",
//    "original_language": "en",
//    "original_title": "Spider-Man: Far from Home",
//    "genre_ids": [
//    28,
//    12,
//    878
//    ],
//    "backdrop_path": "/dihW2yTsvQlust7mSuAqJDtqW7k.jpg",
//    "adult": false,
//    "overview": "Peter Parker and his friends go on a summer trip to Europe. However, they will hardly be able to rest - Peter will have to agree to help Nick Fury uncover the mystery of creatures that cause natural disasters and destruction throughout the continent.",
//    "release_date": "2019-06-28"
//}
