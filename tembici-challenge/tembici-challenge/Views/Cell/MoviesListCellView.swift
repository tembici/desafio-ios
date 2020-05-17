//
//  MoviesListCell.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct MoviesListCellView: View {
    
    @State var selectionTAG: Int? = nil
    @EnvironmentObject var globalState: GlobalState
    @ObservedObject var movieListCellVM: MoviesListCellViewModel
    var movie: Movie
    init(movie: Movie) {
        movieListCellVM = MoviesListCellViewModel(movie: movie)
        self.movie = movie
    }
    
    var body: some View {
        
        ZStack(alignment: .center){
            NavigationLink(destination: MovieDetailView(movie: movieListCellVM.movie, globalState:globalState)
                .environmentObject(globalState)
                , tag: movieListCellVM.id, selection: self.$selectionTAG, label: {
                EmptyView()
            })
                .buttonStyle(PlainButtonStyle())
                .frame(width: 0, height: 0)
                .disabled(true)
                .hidden()     
            
            Button(action: {
                self.selectionTAG = self.movieListCellVM.id
            }, label: {
                VStack (){
                    ZStack(alignment:.top){
                        ImageViewComponent(url: movieListCellVM.urlImage, type: .bigPoster)
                            .cornerRadius(radius: 10, corners: [.topLeft, .topRight])
                            .padding(0)
                        
                    }
                    VStack(alignment: .leading) {
                        
                        Text(movieListCellVM.title)
                            .fontWeight(.heavy)
                            .textStyle(TitleCellStyle())
                            .accessibility(identifier: "movieTitle")
                        
                        Spacer()
                        HStack{
                            Text(movieListCellVM.date)
                                .textStyle(DateCellStyle())
                            Spacer()
                            Image(systemName:self.globalState.favorites.contains(movie) ? "star.fill": "star")
                                .font(.system(size: 12))
                                .foregroundColor(Color(Constants.Design.Color.Gold)).padding(5)
                                .accessibility(identifier: "favoriteStatus")
                        }
                        .padding(.bottom, 10)
                        .padding(.top, 0)
                    }  .frame(width: nil, height: 75, alignment: .top)               .background(Color(Constants.Design.Color.Gray))
                        .cornerRadius(radius: 10, corners: [.bottomLeft, .bottomRight])
                        .padding(.top, -8)
                }
                
                
            }).buttonStyle(ButtonAnimatedStyless())
            
        }
    }
}

struct MoviesListCell_Previews: PreviewProvider {
    @State static var movie = DataContants.sharedInstance.movieModelPreview
    
    
    static var previews: some View {
        MoviesListCellView(movie: movie)
    }
}
