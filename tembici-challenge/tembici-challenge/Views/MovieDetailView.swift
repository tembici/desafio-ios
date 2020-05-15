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
    
    init(movie: Movie) {
        movieDetailVM = MovieDetailViewModel(movie: movie)
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
                            
                            
                        }) {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow).padding(5)
                                .font(.system(size: 30))
                        }       .padding(.trailing, 10)
                        
                    }.padding(10)
                        .padding(.leading, 10)
                }
                VStack(alignment: .leading) {
                    
                    Text("Relase Date: \(movieDetailVM.date)")
                        .padding()
                    
                    Text(movieDetailVM.overview).textStyle(ContentStyle())
                }
                Spacer()
                
            }
        }.navigationBarTitle("", displayMode: .inline)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    @State static var movie = DataContants.sharedInstance.movieModelPreview
    
    static var previews: some View {
        MovieDetailView(movie:movie)
    }
}
