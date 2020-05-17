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
            .font(.custom(Constants.Design.Font.Title, size: 13))
            .fixedSize(horizontal: false, vertical: true)
    }
}
struct BigTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .font(.custom(Constants.Design.Font.Title, size: 25))
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
            .lineLimit(nil)
            .font(.custom(Constants.Design.Font.Title, size: 16))
            .foregroundColor(Color.white)
            .fixedSize(horizontal: false, vertical: true)
        
    }
}

struct ContentStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fixedSize(horizontal: false, vertical: true)
            .lineSpacing(4)
            .foregroundColor(.secondary)
            .lineLimit(nil)
            .padding()
        
        
    }
}

struct DescripitionCellStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fixedSize(horizontal: false, vertical: true)
            .lineSpacing(4)
            .foregroundColor(.secondary)
            .lineLimit(3)
            .padding()
        
        
    }
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
