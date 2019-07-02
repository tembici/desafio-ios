//
//  API.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

class API {
    
    private static let mediaCache = RequestCache(identifier: "Media")
    
    private static func create(request: Request) throws -> URLRequest {
        guard var components = URLComponents(url: request.path, resolvingAgainstBaseURL: false) else {
                throw APIError.malformedURL
        }
        
        var queryItems: [URLQueryItem] = []
        for parameter in request.parameters {
            queryItems.append(URLQueryItem(name: parameter.key, value: parameter.value))
        }
        components.queryItems = queryItems
        
        guard let urlWithComponents = components.url else {
            throw APIError.malformedURL
        }
        var urlRequest = URLRequest(url: urlWithComponents, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 1)
        urlRequest.httpShouldHandleCookies = false
        urlRequest.httpShouldUsePipelining = true
        urlRequest.httpMethod = request.method.rawValue
        
        if let data = request.data {
            urlRequest.httpBody = data
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        return urlRequest
    }
    
    public static func request<T: Codable>(request: Request) throws -> T {
        guard let data: Data = try self.request(request: request) else {
            throw APIError.noContent
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
    
    public static func request(request: Request) throws -> Data? {
        let urlRequest: URLRequest = try API.create(request: request)
        let (data, response, error) = API.process(request: urlRequest)
        
        if let response = response {
            if 200 <= response.statusCode && response.statusCode < 300 {
                return data
            } else {
                throw APIError.error(httpCode: response.statusCode, payload: data)
            }
        }
        
        if let error = error as NSError? {
            throw error
        } else {
            fatalError()
        }
    }
    
    public static func download(request: Request) throws -> Data {
        if request.cache, let data = self.mediaCache[request.path.absoluteString] {
            return data
        }
        
        let urlRequest: URLRequest = try API.create(request: request)
        let (data, response, error) = API.process(request: urlRequest)
        
        if let response = response {
            if 200 <= response.statusCode && response.statusCode < 300, let data: Data = data {
                if request.cache { self.mediaCache[request.path.absoluteString] = data }
                return data
            } else {
                throw APIError.error(httpCode: response.statusCode, payload: data)
            }
        }
        
        if let error = error as NSError? {
            throw error
        } else {
            fatalError()
        }
    }
    
    private static func process(request: URLRequest) -> (Data?, HTTPURLResponse?, Error?) {
        #if DEBUG
        let startTime = CFAbsoluteTimeGetCurrent()
        API.printLog(request: request)
        #endif
        
        let session: URLSession = URLSession(configuration: .default)
        let (data, response, error) = session.performSynchronousRequest(request)
        
        #if DEBUG
        if let url = request.url {
            API.printLog(response: response, url: url, startTime: startTime, data: data)
        }
        #endif
        
        return (data, response, error)
    }

}

#if DEBUG
extension API {
    
    private static func printLog(request: URLRequest) {
        let components = NSURLComponents(string: request.url?.absoluteString ?? "")
        var message = "\n----------------------------------\n\(request.httpMethod ?? "") \(components?.path ?? "")?\(components?.query ?? "") HTTP/1.1\nHost: \(components?.host ?? "")\n"
        
        for (name, value) in request.allHTTPHeaderFields ?? [:] {
            message += "\(name): \(value)\n"
        }
        
        if let string = request.httpBody?.stringValue {
            message += "\(string)\n"
        }
        
        print("\(message)----------------------------------\n")
    }
    
    private static func printLog(response: URLResponse?, url: URL, startTime: CFAbsoluteTime, data: Data?) {
        var message = "\n----------------------------------\nResponse: \(url.absoluteString)\n\((CFAbsoluteTimeGetCurrent() - startTime).humanReadable)\n\n"
        
        if let response = response as? HTTPURLResponse {
            for (name, value) in response.allHeaderFields {
                message += "\(name): \(value)\n"
            }
            
            if let string = data?.stringValue {
                message += "\(string)\n"
            }
        }
        
        print("\(message)----------------------------------\n")
    }
    
}
#endif
