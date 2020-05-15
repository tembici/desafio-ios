//
//  ButtonAnimatedStyle.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct ButtonAnimatedStyless: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
        .opacity(configuration.isPressed ? 0.5 : 1.0)

    }
}
