//
//  NotFoundView.swift
//  tembici-challenge
//
//  Created by Hannah  on 16/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct NotFoundView: View {
    var show: Bool
    
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
            }
            if self.show {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 100))
                
                Text("No movies with this name were found.").textStyle(BigTextStyle())
                    .padding(10)
                
            }
        }.onTapGesture {
            UIApplication.shared.endEditing(true)
        }
        
    }
}

