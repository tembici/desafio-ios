//
//  MovieDetailView.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    
    @ObservedObject var movieDetailVM: MovieDetailViewModel
    @EnvironmentObject var globalState: GlobalState
    init(movie: Movie, globalState: GlobalState ) {
        movieDetailVM = MovieDetailViewModel(movie: movie, globalState: globalState )
    }
    
    var body: some View {
        ScrollView{
            
            VStack {
                VStack() {
                    ImageViewComponent(url: movieDetailVM.urlImage, type:.backdrop)
                    HStack {
                        VStack(alignment: .center, spacing: 8) {
                            Text(movieDetailVM.title)
                                .fontWeight(.heavy)
                                .lineLimit(nil)
                                .font(.custom(Constants.Design.Font.Thonburi, size: 16))
                                .foregroundColor(Color.white)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        Spacer()
                        Button(action: {
                            self.movieDetailVM.favorite()
                        }) {
                            Image(systemName: self.globalState.favorites.contains(movieDetailVM.movie) ? "star.fill" : "star")
                                .foregroundColor(Color.yellow).padding(5)
                                .font(.system(size: 30))
                        }       .padding(.trailing, 10)
                        
                    }.padding(10)
                        .padding(.leading, 10)
                }
                VStack(alignment: .leading) {
                    
                    Text("Relase Date: \(movieDetailVM.date)")
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false){
                                       
                                       HStack(spacing: 10){
                                        ForEach(movieDetailVM.genresList, id: \.self) { genere in
                                               
                                               Text(genere)
                                                   .padding([.horizontal, .vertical], 8)
                                                   .overlay(
                                                       RoundedRectangle(cornerRadius: 5    )
                                                           .stroke(Color.gray, lineWidth: 0.7))
                                               
                                           }
                                           
                                       }
                                   }.padding()
                    
                    Text(movieDetailVM.overview).textStyle(ContentStyle())
                }
                Spacer()
                
            }
        }.navigationBarTitle("", displayMode: .inline)
            .onAppear(){
                self.movieDetailVM.fetchGenres()
        }
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    @State static var movie = DataContants.sharedInstance.movieModelPreview
//
//    static var previews: some View {
//        MovieDetailView(movie:movie)
//    }
//}
