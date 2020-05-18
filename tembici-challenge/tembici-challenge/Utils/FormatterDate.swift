//
//  FormatterDate.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation

class FormatterDate {
    
    
    static func getYear(dateString: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat =  "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString) else {
            return ""
        }
        
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        
        return year
    }
    
    static func getCompleteDate(dateString: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat =  "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString) else {
            return ""
        }
        
        formatter.dateFormat = "MMM d, yyyy"
        let year = formatter.string(from: date)
        
        return year
    }
}


