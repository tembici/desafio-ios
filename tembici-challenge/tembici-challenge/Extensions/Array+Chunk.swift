//
//  Array+Chunk.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation

import Foundation

extension Array {
    func chunked(into size:Int) -> [[Movie]] {
        
        var chunkedArray = [[Movie]]()
        
        for index in 0...self.count {
            if index % size == 0 && index != 0 {
                chunkedArray.append(Array(self[(index - size)..<index]) as! [Movie])
            } else if(index == self.count && chunkedArray.count>=0) {
                chunkedArray.append(Array(self[(index>0 ? index - 1 : index)..<index]) as! [Movie])
            }
        }
        return chunkedArray
    }
}
