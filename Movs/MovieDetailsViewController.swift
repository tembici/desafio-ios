//
//  MovieDetailsViewController.swift
//  BuscaFilmes
//
//  Created by Elias Amigo on 16/03/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class MovieDetailsViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var favoriteButton: UIButton! 
    
    public var movieId: String?
    public var movie: Movie?
    
    private var api: MoviesServices = MoviesServices()
    private var favoriteFullIcon: UIImage?
    private var favoriteEmptyIcon: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteFullIcon = UIImage(named:
            "favorite_full_icon")!
        favoriteEmptyIcon = UIImage(named:
            "favorite_empty_icon")!

        favoriteButton.layer.cornerRadius = favoriteButton.frame.size.width / 2
        favoriteButton.backgroundColor = .clear
        favoriteButton.layer.borderWidth = 3.0
        favoriteButton.layer.borderColor = UIColor.white.cgColor
        favoriteButton.tintColor = .white
        favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        favoriteButton.imageView?.contentMode = .scaleToFill
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: "viewSearchResult", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSearchResult" {
            let tvc = segue.destination as! SearchViewController
            tvc.searchPage = 1
            tvc.searchParameter = searchField.text!
        }
    }
    
    private func loadData() {
        
        api.details(movie: movieId!) { (data, error) in
            
            //            self.activityIndicator.stopAnimating()
            
            guard error == nil else {
                self.showAlert("Não foi possível realizar essa busca.")
                return
            }
            
            guard (data?.lengthOfBytes(using: .utf8))! > 0 else {
                return
            }
            
            var genreDescription: String = ""
            let repository = "https://image.tmdb.org/t/p"
            let jsonResult = JSON.init(parseJSON: data!)
            self.movie = Movie(with: jsonResult)
            var address: String = "\(repository)/w780\(self.movie!.backdropPath)"
            var imageURL = URL(string: address)
            var data = try? Data(contentsOf: imageURL!)
            
            if let imageData = data {
                self.backdropImage?.image = UIImage(data: imageData)
            }
            
            address = "\(repository)/w185\(self.movie!.posterPath)"
            imageURL = URL(string: address)
            data = try? Data(contentsOf: imageURL!)
            
            if let imageData = data {
                self.posterImage?.image = UIImage(data: imageData)
            }
            
            self.movieTitle.text = self.movie?.title
            self.movieReleaseDate.text = "Lançamento: \(self.movie!.releaseDate)"
            self.movieOverview.text = self.movie?.overview
            self.movieScore.text = String(self.movie?.voteAverage ?? 0)
            
            for genre in (self.movie?.genres)! {
                genreDescription += " \(genre),"
            }
            
            self.movieGenre.attributedText = NSAttributedString(string: genreDescription)
            
            self.movieGenre.text = "\(self.movieGenre.text!.dropFirst())"
            self.movieGenre.text = "\(self.movieGenre.text!.dropLast())"
            
            let circularProgress = CircularProgressView(frame: CGRect(x: 10.0, y: 30.0, width: ((self.movieScore?.frame.width)! * 0.8), height: ((self.movieScore?.frame.height)!  * 0.8)))
            circularProgress.center = (self.movieScore?.center)!
            circularProgress.setProgressWithAnimation(duration: 1.0, value: (Float(self.movie!.voteAverage / 10.0)))
            self.movieScore?.addSubview(circularProgress)
            
            if (self.movie?.favorite)! {
                self.favoriteButton.setImage(self.favoriteFullIcon, for: .normal)
            } else {
                self.favoriteButton.setImage(self.favoriteEmptyIcon, for: .normal)
            }
        }
    }
    
    @IBAction func setFavorite(_ sender: Any) {
        
        if (movie?.favorite)! {
            self.favoriteButton.setImage(self.favoriteEmptyIcon, for: .normal)
            movie?.favorite = false
        } else {
            self.favoriteButton.setImage(self.favoriteFullIcon, for: .normal)
            movie?.favorite = true
            
            try? {
                CoreDataServices.shared.saveFavoriteMovie(

            }
            
        }
    }
}
