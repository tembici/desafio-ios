//
//  MoviesResponse.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 27/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation
import CoreData

struct MoviesReponse: Decodable {
    var page: Int = 1
    var total_pages: Int = 1
    var results: [MovieResult] = []
}

struct MovieResult {
    var id: Int = 0
    var title: String? = ""
    var originalTitle: String? = ""
    var posterPath: String? = ""
    var video: Bool? = false
    var originalLanguage: String? = ""
    var backdropPath: String? = ""
    var adult: Bool? = false
    var overview: String? = ""
    var releaseDate: String? = ""
    var genres: [Genres]? = []
    var favorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case video
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genres
    }
}

extension MovieResult: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
    }
}

extension MovieResult {
    
    func toNSManagedObject() -> NSManagedObject? {
        let movieObject = CoreDataHelper().getObject(in: Entitys.Movie)
        
        movieObject?.setValue(self.id, forKey: "id")
        movieObject?.setValue(self.title, forKey: "title")
        movieObject?.setValue(self.adult, forKey: "adult")
        movieObject?.setValue(self.favorite, forKey: "favorite")
        movieObject?.setValue(self.originalTitle, forKey: "originalTitle")
        movieObject?.setValue(self.posterPath, forKey: "posterPath")
        movieObject?.setValue(self.releaseDate, forKey: "releaseDate")
        movieObject?.setValue(self.overview, forKey: "overview")
        
        return movieObject
    }
    
    func toMovieObject(object: NSManagedObject) -> MovieResult {
        return MovieResult(id: object.value(forKey: "id") as! Int,
                           title: object.value(forKey: "title") as? String,
                           originalTitle: object.value(forKey: "originalTitle") as? String,
                           posterPath: object.value(forKey: "posterPath") as? String,
                           video: nil,
                           originalLanguage: nil,
                           backdropPath: nil,
                           adult: object.value(forKey: "adult") as? Bool ?? false,
                           overview: object.value(forKey: "overview") as? String,
                           releaseDate: object.value(forKey: "releaseDate") as? String,
                           genres: nil,
                           favorite: object.value(forKey: "favorite") as? Bool ?? false)
    }
}
