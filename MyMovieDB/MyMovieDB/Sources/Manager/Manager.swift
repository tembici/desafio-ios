//
//  Manager.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 26/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation
import Alamofire

class Manager {
    func requestToken(param: BasicRequest, completionHandler: @escaping (_ response: TokenResponse?, _ error: Error?)-> Void) {
        request(endpoint: Endpoint.authToken, httpMethod: .post, urlParams: param, headerParams: EmptyRequest(), bodyParams: EmptyRequest(), response: TokenResponse()) { (decodableObj, error) in
            if let _error = error {
                completionHandler(nil, _error)
            }
            else {
                completionHandler(decodableObj, nil)
            }
        }
    }
}

extension Manager {
    fileprivate func request<T: Encodable, U: Encodable, V: Encodable, X: Decodable>(endpoint: Endpoint, httpMethod: HTTPMethod, urlParams: T?, headerParams: U?, bodyParams: V?, response: X, completionHandler: @escaping (_ response: X?, _ error: Error?)-> Void) {
        
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
    
    private func parseObj<U: Decodable>(responseObj: U, data: Data, completionHandler: @escaping (_ response: U?, _ error: Error?)-> Void) {
        do {
            let resonseObj = try JSONDecoder().decode(U.self, from: data)
            completionHandler(resonseObj, nil)
        } catch {
            completionHandler(nil, error)
        }
    }
}
