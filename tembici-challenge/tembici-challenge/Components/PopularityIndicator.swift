//
//  PopularityIndicator.swift
//  tembici-challenge
//
//  Created by Hannah  on 16/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct PopularityIndicator:  View {
    public let score: Int
    
    @State private var isDisplayed = false
    
    public init(score: Int) {
        self.score = score
    }
    
    var scoreColor: Color {
        get {
            if score < 40 {
                return .red
            } else if score < 60 {
                return .orange
            } else if score < 75 {
                return .yellow
            }
            return .green
        }
    }
    
    var overlay: some View {
        ZStack {
            Circle()
                .trim(from: 0,
                      to: isDisplayed ? CGFloat(score) / 100 : 0)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [1]))
                .foregroundColor(scoreColor)
                .animation(Animation.interpolatingSpring(stiffness: 60, damping: 10).delay(0.1))
        }
        .rotationEffect(.degrees(-90))
        .onAppear {
            self.isDisplayed = true
        }
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.clear)
                .frame(width: 40)
                .overlay(overlay)
                .shadow(color: scoreColor, radius: 4)
            Text("\(score)%")
                .font(Font.system(size: 10))
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
        .frame(width: 40, height: 40)
    }
}
#if DEBUG
struct PopularityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PopularityIndicator(score: 80)
            PopularityIndicator(score: 10)
            PopularityIndicator(score: 30)
            PopularityIndicator(score: 50)
        }
    }
    
}
#endif
