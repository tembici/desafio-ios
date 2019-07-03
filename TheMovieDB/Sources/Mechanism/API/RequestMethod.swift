//
//  RequestMethod.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

/// The request method, based on HTTP methods.
public enum RequestMethod: String {
    /// Delete method, used to delete information.
    case delete = "DELETE"
    
    /// Get method, used to return information.
    case get = "GET"
    
    /// Patch method, used to change information.
    case patch = "PATCH"
    
    /// Post method, used for create new information.
    case post = "POST"
}
