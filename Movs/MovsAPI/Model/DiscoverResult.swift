//
//  DiscoverResult.swift
//  Movs
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import Foundation

struct DiscoverResult: Codable {
    let voteCount: Int
    let voteAverage: Float
    let originalLanguage, releaseDate, backdropPath: String
    let genreIDS: [Int]
    let posterPath: String
    let video: Bool
    let title: String
    let adult: Bool
    let overview: String
    let id: String
    let originalTitle: String
    let popularity: Double
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case originalLanguage = "original_language"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case posterPath = "poster_path"
        case video, title, adult, overview, id
        case originalTitle = "original_title"
        case popularity
    }
}

// MARK: Convenience initializers and mutators

extension DiscoverResult {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DiscoverResult.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        voteCount: Int? = nil,
        voteAverage: Float? = nil,
        originalLanguage: String? = nil,
        releaseDate: String? = nil,
        backdropPath: String? = nil,
        genreIDS: [Int]? = nil,
        posterPath: String? = nil,
        video: Bool? = nil,
        title: String? = nil,
        adult: Bool? = nil,
        overview: String? = nil,
        id: String? = nil,
        originalTitle: String? = nil,
        popularity: Double? = nil
        ) -> DiscoverResult {
        return DiscoverResult(
            voteCount: voteCount ?? self.voteCount,
            voteAverage: voteAverage ?? self.voteAverage,
            originalLanguage: originalLanguage ?? self.originalLanguage,
            releaseDate: releaseDate ?? self.releaseDate,
            backdropPath: backdropPath ?? self.backdropPath,
            genreIDS: genreIDS ?? self.genreIDS,
            posterPath: posterPath ?? self.posterPath,
            video: video ?? self.video,
            title: title ?? self.title,
            adult: adult ?? self.adult,
            overview: overview ?? self.overview,
            id: id ?? self.id,
            originalTitle: originalTitle ?? self.originalTitle,
            popularity: popularity ?? self.popularity
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

fileprivate func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
