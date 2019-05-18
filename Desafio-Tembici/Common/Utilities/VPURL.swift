//
//  VPURL.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import Alamofire

internal struct VPURL: URLConvertible {
    
    var url: String
    
    init(urlString: String) {
        url = urlString
    }
    
    public func asURL() throws -> URL {
        return URL(string: url)!
    }
}
