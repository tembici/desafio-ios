//
//  APIError.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

enum APIError: Error {
    case malformedURL
    case noContent
    case error(httpCode: Int, payload: Data?)
}
