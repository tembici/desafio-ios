//
//  CodableExtensions.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 26/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation

extension Encodable {
    /// Convert Encodable type to urlQueryItems
    public func toURLQueryItem() throws -> [URLQueryItem] {
        var urlQueryItems: [URLQueryItem] = []
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        let json = try JSONSerialization.jsonObject(with: data)
        let dict = json as? [String: String]
        
        if let _dict = dict {
            for iten in _dict {
                urlQueryItems.append(URLQueryItem(name: iten.key, value: iten.value))
            }
        }
        return urlQueryItems
    }
    
    /// Convert Encodable type to jsonData.
    public func toJsonData() throws -> Data {
        let jsonData = try JSONEncoder().encode(self)
        return jsonData
    }
    
    public func toDict() throws -> [String: String]? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let dict = try JSONSerialization.jsonObject(with: jsonData)
            if let dictionary = dict as? [String: String] {
                return dictionary
            }
        } catch {
            Logger().log(error.localizedDescription)
        }
        return nil
    }
}
