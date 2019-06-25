//
//  Date+Extensions.swift
//  TheMovieApp
//
//  Created by Wilson Kim on 25/06/19.
//  Copyright © 2019 WilsonKim. All rights reserved.
//

import Foundation

extension Date {
    static func dateFrom(string: String, withFormat format: String? = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: string)
        
        return date
    }
}
