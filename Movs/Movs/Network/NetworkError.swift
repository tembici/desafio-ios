//
//  NetworkError.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case parserError
    case unknown
    case noJSONData
    
    var localizedDescription: String? {
        switch  self {
        case .noJSONData:
            return "Response not provide a JSON data has been found"
        case .parserError:
            return "Error pasing JSON to data has been found"
        case .unknown:
            return "Unknown error has been found"
        }
    }
}


