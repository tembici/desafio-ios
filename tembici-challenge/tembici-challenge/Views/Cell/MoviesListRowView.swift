//
//  MoviesListRow.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct MoviesListRowView: View {
    
    var moviesRow: [Movie]
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            
            ForEach(self.moviesRow, id: \.id) { movie in
                VStack{
                    MoviesListCellView(movie: movie)
                }
                .padding(.bottom, 8)
            }
            Spacer()
            
        }
    }
    
}
    struct MoviesListRow_Previews: PreviewProvider {
        
        @State static var moviesRow = [Movie]()
        
        static var previews: some View {
            MoviesListRowView(moviesRow: moviesRow)
        }
}
