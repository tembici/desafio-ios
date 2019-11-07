//
//  EndPointType.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 06/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
