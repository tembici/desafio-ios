//
//  ImageSizeHelper.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//


import SwiftUI

class ImageSizeHelper{
    
    static func getSizeBigPoster() -> CGSize {
        let screenSize = UIScreen.main.bounds
        var size = CGSize()
        size.width = screenSize.width/2 - 10
        size.height = ((screenSize.width/2) - 10) * 1.5
        return  size
        
    }
    
    static func getSizeSmallPoster() -> CGSize {
           let screenSize = UIScreen.main.bounds
           var size = CGSize()
           size.width = screenSize.width/3 - 10
           size.height = ((screenSize.width/3) - 10) * 1.5
           return  size
           
       }
    
    static func getSizeBackdrop() -> CGSize {
          let screenSize = UIScreen.main.bounds
          var size = CGSize()
          size.width = screenSize.width
          size.height = screenSize.width * 0.562
          return  size
          
      }
}
