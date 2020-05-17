//
//  TextStyles.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct TitleCellStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .lineLimit(2)
            .padding(.leading, 10)
            .padding(.top, 10)
            .padding(.bottom, 0)
            .font(.custom(Constants.Design.Font.Thonburi, size: 13))
            .fixedSize(horizontal: false, vertical: true)
    }
}
struct BigTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .font(.custom(Constants.Design.Font.Thonburi, size: 25))
            .fixedSize(horizontal: false, vertical: true)
    }
}
struct DateCellStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .lineLimit(1)
            .multilineTextAlignment(.trailing)
            .padding(.leading, 10)
            .font(.custom(Constants.Design.Font.HelveticaNeueThin, size: 12))
    }
}

struct SubTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineSpacing(8)
            .font(.custom(Constants.Design.Font.Thonburi, size: 14))
            .foregroundColor(.primary)
        
    }
}

struct ContentStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fixedSize(horizontal: false, vertical: true)
            .lineSpacing(4)
            .foregroundColor(.secondary)
            .font(.custom(Constants.Design.Font.Thonburi, size: 14))
            .lineLimit(nil)
            .padding()
        
        
    }
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
