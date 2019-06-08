//
//  BasicRequest.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 26/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation

struct BasicRequest {
    var apiKey: String? = Bundle.main.infoDictionary?["AppKey"] as? String ?? ""
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
    }
}

extension BasicRequest: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(apiKey, forKey: .apiKey)
    }
}
