//
//  Request.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

class Request {
    let method: RequestMethod
    let path: URL
    let parameters: [String: String]
    let data: Data?
    let cache: Bool
    
    static func get(domain: String, endpoint: String, parameters: [String: String] = [:], cache: Bool = false) -> Request {
        return Request(method: .get,
                       domain: domain,
                       endpoint: endpoint,
                       parameters: parameters,
                       cache: cache)
    }
    
    static func get(url: URL, parameters: [String: String] = [:], cache: Bool = false) -> Request {
        return Request(method: .get,
                       url: url,
                       parameters: parameters,
                       cache: cache)
    }
    
    static func get(path: String, parameters: [String: String] = [:], cache: Bool = false) -> Request {
        return Request(method: .get,
                       domain: path,
                       endpoint: "",
                       parameters: parameters,
                       cache: cache)
    }
    
    private init(method: RequestMethod, domain: String, endpoint: String, parameters: [String: String], cache: Bool) {
        self.method = method
        self.path = URL(string: "\(domain)\(endpoint)")!
        self.parameters = parameters
        self.data = nil
        self.cache = cache
    }
    
    private init(method: RequestMethod, url: URL, parameters: [String: String], cache: Bool) {
        self.method = method
        self.path = url
        self.parameters = parameters
        self.data = nil
        self.cache = cache
    }
    
}
