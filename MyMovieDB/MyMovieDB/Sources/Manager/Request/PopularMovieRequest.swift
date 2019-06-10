//
//  PopularMovieRequest.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 08/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation

struct PopularMovieParam {
    var apiKey: String? = Bundle.main.infoDictionary?["AppKey"] as? String ?? ""
    var page: String
    
    init(page: Int = 1) {
        self.page = String(page)
    }
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case page
    }
}

extension PopularMovieParam: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(apiKey, forKey: .apiKey)
        try container.encode(page, forKey: .page)
    }
}
