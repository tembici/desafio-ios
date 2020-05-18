//
//  UIApplication+Keyboard.swift
//  tembici-challenge
//
//  Created by Hannah  on 16/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

extension UIApplication { func endEditing(_ force: Bool) {
    self.windows .filter{$0.isKeyWindow} .first? .endEditing(force) }
    
}
