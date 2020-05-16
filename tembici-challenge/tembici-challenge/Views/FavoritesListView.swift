//
//  FavoritesListView.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct FavoritesListView: View {
      @EnvironmentObject var globalState: GlobalState
     
     var body: some View {
         return
             ZStack{
                 List{
                     ForEach(globalState.favorites, id: \.self) { movie in
                         
                         FavoritesListCellView(movie: movie)
                     }
                     
                 }
         }
     }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
    }
}
