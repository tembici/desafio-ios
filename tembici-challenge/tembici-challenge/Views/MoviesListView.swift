//
//  MoviesListView.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct MoviesListView: View {
    
    @ObservedObject var moviesListVM = MoviesListViewModel()
 
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        self.fetchMovies()
    }
    
    func fetchMovies()-> Void{
           self.moviesListVM.fetchMovies()
       }
       
    var body: some View {
        ZStack{
            LoadingView(isShowing: moviesListVM.isLoading && !moviesListVM.loadingMore , content: {
                VStack{
                    List{
                        Section(header:  SearchBar(text: self.$moviesListVM.searchText, placeholder: "search").listRowInsets(EdgeInsets())) {

                        ForEach(0..<self.moviesListVM.moviesList.count, id: \.self) { indexRow in
                            VStack {
                                MoviesListRowView(moviesRow: self.moviesListVM.moviesList[indexRow])
                                
                            }.listRowInsets(EdgeInsets())
                                .onAppear(){
                                    self.moviesListVM.fetchLoadMore(row: indexRow)
                            }
                        }
                    }
                        HStack(){
                            Spacer()
                            ActivityIndicator(isAnimating: true, style: .medium)
                            Spacer()
                        }
                    }.onTapGesture {return}
                }.padding(.top, 8)
                
            })
//            ErrorView(show: moviesListVM.showMsgError, tapView: self.fetchMovies)
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
