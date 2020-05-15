//
//  MovieDetailView.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    
    init(movie: Movie) {
        
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    @State static var movie = DataContants.sharedInstance.movieModelPreview

    static var previews: some View {
        MovieDetailView(movie:movie)
    }
}
