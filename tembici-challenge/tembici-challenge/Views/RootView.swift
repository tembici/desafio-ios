//
//  RootView.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var globalState: GlobalState
    
    init() {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(named:Constants.Design.Color.Gold)!
            ,
            .font : UIFont(name:Constants.Design.Font.Thonburi, size: 40)!]
        
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor:UIColor(named:Constants.Design.Color.Gold)!,
            .font : UIFont(name: Constants.Design.Font.HelveticaNeueThin, size: 20)!]
    }
    
    var body: some View {
        NavigationView {
            
            TabView {
                MoviesListView()
                    .tabItem {
                        Image(systemName: "film.fill")
                        Text("Movies")
                }
                FavoritesListView()
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Favorites")
                }
            }.navigationBarTitle(Text("Popular Movies"))
                .accentColor(Color(Constants.Design.Color.Gold))
        }  .onAppear(){
            
            self.globalState.fetchGenres()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
