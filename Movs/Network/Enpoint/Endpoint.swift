//
//  Endpoint.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

// MARK: - Typealias

typealias Headers = [String: String]
typealias Parameters = [String: Any]

let APIKey: String = "9e5d54f168ccf64e975676401c7becb8"

// MARK: - Protocol

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: Params { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}

// MARK: - Enums

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

enum ParametersEncoding {
    case url
    case json
}

enum Params {
    case requestPlain
    case requestParameters(Parameters)
}

