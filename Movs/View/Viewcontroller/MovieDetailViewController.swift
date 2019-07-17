//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Ivan Ortiz on 16/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import UIKit

class MovieDetailViewController : UITableViewController {

    @IBOutlet weak var imvBanner: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnFavoriteIcon: UIButton!
    
    var isFavorite = false
    
    var movie:Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(fixGenres), name: NSNotification.Name(rawValue: "didGetGenreList"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isFavorite = false
        if let _ = FavoriteList.shared.list.firstIndex(where: { $0.id == movie?.id }) {
            isFavorite = true
        }
        loadFavoriteStatus()
    }
    
    func setupViews(){
        imvBanner.imageFromUrl(movie.poster_path ?? "", placeHolder: nil)
        lblTitle.text = movie.title
        lblYear.text = movie.release_date?.year
        lblGenres.text = fixGenres()
        lblDescription.text = movie.overview
    }
    
    func loadFavoriteStatus()
    {
        var nameImage = "favorite_gray_icon"
        if isFavorite
        {
            nameImage = "favorite_full_icon"
        }
        btnFavoriteIcon.setImage(UIImage(named: nameImage), for: UIControl.State.normal)
    }
    
    @IBAction func favoritePressed(sender:Any?)
    {
        isFavorite = !isFavorite
        loadFavoriteStatus()
        FavoriteList.shared.favoriteHandler(with: movie!)
    }
    
    @objc func fixGenres() -> String
    {
        if movie!.genre_ids != nil
        {
            var strGenres = ""
            for n in 0...movie!.genre_ids!.count - 1 {
                let searchedId = movie!.genre_ids![n]
                if let index = GenresList.shared.list.firstIndex(where: { $0.id == searchedId }) {
                    strGenres = strGenres + (GenresList.shared.list[index].name ?? "") + ", "
                }
            }
            return String(strGenres.dropLast(2))
        }
        
        return "-"
    }
}
