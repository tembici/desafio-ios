//
//  Wait.swift
//  TFilmesTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 08/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

class Do {

    static func wait(seconds: Int, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(seconds)) {
            completion()
        }
    }

}


