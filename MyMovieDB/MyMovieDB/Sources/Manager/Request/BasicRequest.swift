//
//  BasicRequest.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 26/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation

struct BasicRequest: Encodable {
    var api_key: String? = Bundle.main.infoDictionary?["AppKey"] as? String ?? ""
    var page: String
    
    init(page: Int = 1) {
        self.page = String(page)
    }
}

struct PopularMovieParam: Encodable {
    var api_key: String? = Bundle.main.infoDictionary?["AppKey"] as? String ?? ""
    var page: String
    
    init(page: Int = 1) {
        self.page = String(page)
    }
}
