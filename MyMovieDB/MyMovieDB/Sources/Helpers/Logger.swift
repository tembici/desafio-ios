//
//  Logger.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 26/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation

class Logger {
    
    /// Print some string just in DEBUG mode.
    func log(_ printable: String?) {
        #if DEBUG
        print(printable ?? "")
        #endif
    }
}
