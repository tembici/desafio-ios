//
//  DateExtensions.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

extension Date {

    init?(from string: String, format: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        guard let date = dateFormatter.date(from: string) else {
            return nil
        }

        self = date
    }

    func getYear() -> Int {
        return Calendar.current.component(.year, from: self)
    }

}
