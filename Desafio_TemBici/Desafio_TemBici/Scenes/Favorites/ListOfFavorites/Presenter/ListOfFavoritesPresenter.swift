// 
//  ListOfFavoritesPresenter.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class ListOfFavoritesPresenter {
    
    //MARK: PROPERTIES
    private(set) weak var view: ListOfFavoritesView!
    private var router: ListOfFavoritesRouter
    
    //MARK: MANAGER
    var favorites: [Favorite] = []
    var filtered: [Favorite] = []
    var isFiltered: Bool = false
    
    //MARK: COREDATA
    let coreData = CoreDataManager.sharedManager
  
    //MARK: INIT
    init(view: ListOfFavoritesView, router: ListOfFavoritesRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: VIEW LIFE CYCLE
    func viewDidLoad() {
        view.configureUI()
    }
    
    func viewDidAppear() {
        view.startLoading()
        getFavorites()
    }
    
    //MARK: FAVORITES
    private func getFavorites() {
        if coreData.fetchMoviesFavorited() != nil {
            favorites = coreData.fetchMoviesFavorited()!
            view.stopLoading()
            
            if favorites.count == 0 {
                view.stopLoading()
                view.tableViewIsHidden()
                view.display(message: "You didn't favorited \nany movie!!")
            } else {
                view.tableViewNotHidden()
                view.reloadData()
            }
        } else {
            view.tableViewIsHidden()
            view.display(message: "An error has occurred. \nPlease try again later.")
        }
    }
    
    //MARK: FILTERED
    func filtered(_ searchText: String, scope: String = "All") {
        if searchText != "" {
            isFiltered = true
            filtered = favorites.filter { item in
                if let name = item.name {
                    return (name.lowercased().contains(searchText.lowercased()))
                }
                return false
            }
        } else {
            isFiltered = false
            filtered = favorites
        }
        
        if filtered.count == 0 {
            view.display(message: "We didn't find any \nmovies with this name")
            view.tableViewIsHidden()
        } else {
            view.display(message: "")
            view.tableViewNotHidden()
        }
        
        view.reloadData()
    }
    
    //MARK: UNFAVORITE
    func delete(row: Int) {
        coreData.delete(favorite: favorites[row])
        getFavorites()
    }
    
    //MARK: CELL
    func configure(_ cell: FavoriteCell, index: Int) {
        var f: Favorite?
        
        if isFiltered {
            f = filtered[index]
        } else {
            f = favorites[index]
        }
        
        guard let favorite = f else { return }
        ManagerImage.shared.downloadImageFrom(favorite.url ?? "") { (favoriteImage) in
            cell.favoriteModel = FavoriteModel(movieName: favorite.name ?? "",
                                               movieImage: favoriteImage,
                                               movieDate: favorite.date ?? "",
                                               movieOverview: favorite.overview ?? "")
        }
    }
    
    //MARK: NUMBER OF ROWS IN SECTION
    func numberOfRowsInSection() -> Int {
        if isFiltered {
            return filtered.count
        } else {
            return favorites.count
        }
    }
    
    //MARK: NAVIGATION
    func prepare(segue: UIStoryboardSegue, sender: Any?) {
        router.prepare(segue: segue, sender: sender)
    }
    
}
