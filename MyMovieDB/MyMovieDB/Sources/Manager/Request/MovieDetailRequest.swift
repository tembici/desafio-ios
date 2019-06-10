//
//  MovieDetailRequest.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 07/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation

struct MovieDetailRequest {
    var apiKey: String? = Bundle.main.infoDictionary?["AppKey"] as? String ?? ""
    var language: String = Bundle.main.infoDictionary?["AppLanguage"] as? String ?? ""

    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case language
    }
}

extension MovieDetailRequest: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(apiKey, forKey: .apiKey)
        try container.encodeIfPresent(language, forKey: .language)
    }
}
