//
//  URLRequest+Extension.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

// MARK: - Extension URLRequest -

extension URLRequest {
    
    init(service: Endpoint) {
        let urlComponents = URLComponents(service: service)
        self.init(url: urlComponents.url!)
        
        httpMethod = service.method.rawValue
        service.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        
        guard case let .requestParameters(parameters) = service.params,
            service.parametersEncoding == .json else { return }
        httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    }
}
