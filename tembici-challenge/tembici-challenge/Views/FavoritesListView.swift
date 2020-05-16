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
    
    @ObservedObject var favoritesVM: FavoritesListViewModel
    
    init(globalState: GlobalState ) {
        favoritesVM = FavoritesListViewModel(globalState: globalState)
    }
    
    var body: some View {
        return
            ZStack{
                List{
                    ForEach(favoritesVM.favoriteList, id: \.self) { movie in
                        
                        FavoritesListCellView(movie: movie)
                    }                       .onDelete(perform:favoritesVM.deleteFavorite(at:))
                    
                    
                }
            }.onAppear(){
                self.favoritesVM.favoriteList = self.globalState.favorites
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView(globalState: GlobalState())
    }
}
