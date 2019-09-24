//
//  DateHelper.swift
//  Movs
//
//  Created by Miguel Pimentel on 23/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation


class DateHelper {
    
    /// Format Date from ISO Datetime to dd/mm/yyyy
    ///
    /// - Parameters:
    ///   - dateString: stringfied date
    ///   - format: output date format
    /// - Returns: stringfied date according to format
    static public func formattedDateFromString(dateString: String?,
                                               withFormat format: String) -> String? {
        guard let dateStringfied = dateString else { return nil }
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormatter.Pattern.year.rawValue
        
        if let date = inputFormatter.date(from: dateStringfied) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
}
