//
//  RootView.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import SwiftUI

struct RootView: View {
    var globalState = GlobalState()
    init() {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(named:Constants.Design.Color.Gold)!
            ,
            .font : UIFont(name:Constants.Design.Font.Title, size: 40)!]
        
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor:UIColor(named:Constants.Design.Color.Gold)!,
            .font : UIFont(name: Constants.Design.Font.Title, size: 20)!]
    }
    
    var body: some View {
        NavigationView {
            
            TabView {
                MoviesListView()
                    .tabItem {
                        Image(systemName: "film.fill")
                        Text("Movies")
                }
                FavoritesListView(globalState: globalState)
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Favorites")
                }
            }.navigationBarTitle(Text("Movs"))
                .accentColor(Color(Constants.Design.Color.Gold))
        }.environmentObject(globalState)
        .accentColor(Color(Constants.Design.Color.Gold))

    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
