//
//  Manager.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 26/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation

class Manager {
    // ...
}

extension Manager {
    func request<T: Encodable, U: Encodable, V: Encodable, X: Decodable>(endpoint: Endpoint, urlParams: T?, headerParams: U?, bodyParams: V?, response: X, completionHandler: @escaping (_ response: X?, _ error: Error?)-> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = baseUrl
        urlComponents.path = endpoint.rawValue
        
        do {
            urlComponents.queryItems = try urlParams.toURLQueryItem()
            
            let _headerParams = try headerParams.toDict()
            let _bodyParams = try bodyParams.toDict()
            
            Alamofire.request(urlComponents, method: httpMethod, parameters: _bodyParams, headers: _headerParams).responseData { (responseData) in
                if let data = responseData.data {
                    Logger().log(String(data: data, encoding: .utf8))
                    self.parseObj(responseObj: response, data: data, completionHandler: completionHandler)
                }
                else {
                    completionHandler(nil, responseData.error)
                }
            }
        } catch {
            completionHandler(nil, error)
        }
    }
}
