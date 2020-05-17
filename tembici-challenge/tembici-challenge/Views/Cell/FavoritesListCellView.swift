//
//  FavoritesListCellView.swift
//  tembici-challenge
//
//  Created by Hannah  on 16/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct FavoritesListCellView: View {
    
    @State var selectionTAG: Int? = nil
    @EnvironmentObject var globalState: GlobalState
    @ObservedObject var favoritesCellVM: FavoritesListCellViewModel
    
    init(movie: Movie) {
        favoritesCellVM = FavoritesListCellViewModel(movie: movie)
    }
    
    var body: some View {
        ZStack(alignment: .center){
            
            NavigationLink(destination: MovieDetailView(movie: favoritesCellVM.movie, globalState: globalState) , tag: favoritesCellVM.id, selection: self.$selectionTAG, label: {
                EmptyView()
            })
                .buttonStyle(PlainButtonStyle())
                .frame(width: 0, height: 0)
                .disabled(true)
                .hidden()
            
            Button(action:{
                UIApplication.shared.endEditing(true)
                self.selectionTAG = self.favoritesCellVM.id
            }) {
                
                HStack{
                    ImageViewComponent(url: favoritesCellVM.urlImage, type: .smallPoster).cornerRadius(10)
                        .shadow(radius: 10)
                    VStack{
                        HStack{
                            Text(favoritesCellVM.title).font(.headline)
                                .lineLimit(2)
                            Spacer()
                        }
                        HStack(spacing: 10){
                            PopularityIndicator(score: favoritesCellVM.voteAverage)
                            
                            Text(favoritesCellVM.date)
                            Spacer()
                        }
                        Text(favoritesCellVM.overView).font(.body).lineLimit(3)
                        Spacer()
                        
                    }
                }
            }.buttonStyle(ButtonAnimatedStyless())
        }.onDisappear{
            self.selectionTAG = nil
        }
        
    }
}

struct FavoritesListCellView_Previews: PreviewProvider {
    @State static var movie = DataContants.sharedInstance.movieModelPreview
    
    static var previews: some View {
        FavoritesListCellView(movie: movie)
    }
}
