//
//  Date+Extensions.swift
//  TheMovieApp
//


import Foundation

extension Date {
    static func dateFrom(string: String, withFormat format: String? = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: string)
        
        return date
    }
    
    func getDayValue() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func getMonthValue() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    func getYearValue() -> Int {
        return Calendar.current.component(.year, from: self)
    }
}
