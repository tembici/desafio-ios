//
//  Manager.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 26/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation
import Alamofire

var app_key: String = Bundle.main.infoDictionary?["AppKey"] as? String ?? ""

class Manager {
    func requestMovies(completionHandler: @escaping (_ response: MoviesReponse?, _ error: Error?)-> Void) {
        request(endpoint: Endpoint.popularMovie.rawValue, httpMethod: .get, urlParams: BasicRequest(), headerParams: EmptyRequest(), bodyParams: EmptyRequest(), response: MoviesReponse()){ (decodableObj, error) in
            if let _error = error {
                completionHandler(nil, _error)
            }
            else {
                completionHandler(decodableObj, nil)
            }
        }
    }
    
    func requestDetail(param: String, completionHandler: @escaping (_ response: MovieResult?, _ error: Error?)-> Void) {
        request(endpoint: "\(Endpoint.movieDetail.rawValue)\(param)", httpMethod: .get, urlParams: MovieDetailRequest(), headerParams: EmptyRequest(), bodyParams: EmptyRequest(), response: MovieResult()){ (decodableObj, error) in
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
    
    fileprivate func request<T: Encodable, U: Encodable, V: Encodable, X: Decodable>(endpoint: String, httpMethod: HTTPMethod, urlParams: T?, headerParams: U?, bodyParams: V?, response: X, completionHandler: @escaping (_ response: X?, _ error: Error?)-> Void) {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = Bundle.main.infoDictionary?["AppScheme"] as? String ?? ""
        urlComponents.host = Bundle.main.infoDictionary?["BaseUrl"] as? String ?? ""
        urlComponents.path = endpoint
        
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
