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

class Movie: NSObject, NSCoding, Codable{
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
    
    required init(coder decoder: NSCoder) {

        vote_count = decoder.decodeObject(forKey: "vote_count") as? Int ?? 0
        id = decoder.decodeObject(forKey: "id") as? Int ?? 0
        video = decoder.decodeObject(forKey: "video") as? Bool ?? false
        vote_average = decoder.decodeObject(forKey: "vote_average") as? Float ?? 0.0
        title = decoder.decodeObject(forKey: "title") as? String ?? ""
        popularity = decoder.decodeObject(forKey: "popularity") as? Double ?? 0.0
        poster_path = decoder.decodeObject(forKey: "poster_path") as? String ?? ""
        original_language = decoder.decodeObject(forKey: "original_language") as? String ?? ""
        original_title = decoder.decodeObject(forKey: "original_title") as? String ?? ""
        genre_ids = decoder.decodeObject(forKey: "genre_ids") as? [Int] ?? [Int]()
        backdrop_path = decoder.decodeObject(forKey: "backdrop_path") as? String ?? ""
        adult = decoder.decodeObject(forKey: "adult") as? Bool ?? false
        overview = decoder.decodeObject(forKey: "overview") as? String ?? ""
        release_date = decoder.decodeObject(forKey: "release_date") as? String ?? ""

    }

    func encode(with coder: NSCoder) {
        coder.encode(vote_count, forKey: "vote_count")
        coder.encode(id, forKey: "id")
        coder.encode(video, forKey: "video")
        coder.encode(vote_average, forKey: "vote_average")
        coder.encode(title, forKey: "title")
        coder.encode(popularity, forKey: "popularity")
        coder.encode(poster_path, forKey: "poster_path")
        coder.encode(original_language, forKey: "original_language")
        coder.encode(original_title, forKey: "original_title")
        coder.encode(genre_ids, forKey: "genre_ids")
        coder.encode(backdrop_path, forKey: "backdrop_path")
        coder.encode(adult, forKey: "adult")
        coder.encode(overview, forKey: "overview")
        coder.encode(release_date, forKey: "release_date")
    }
}

struct GenresData: Codable {
    var genres: [Genre]
}

class Genre: NSObject, NSCoding, Codable {
    var id:Int?
    var name:String?
    
    required init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey: "id") as? Int ?? 0
        name = decoder.decodeObject(forKey: "name") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
    }
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
