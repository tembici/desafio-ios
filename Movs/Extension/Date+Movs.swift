//
//  Date+Movs.swift
//  Movs
//
//  Created by Ivan Ortiz on 16/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import UIKit

extension String {
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
    var year: String? {
        if date != nil
        {
            let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
            let year = (calendar?.component(NSCalendar.Unit.year, from: date!))!
            return "\(year)"
        }
        return ""
    }
}
