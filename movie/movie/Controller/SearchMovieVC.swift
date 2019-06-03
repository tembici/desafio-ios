//
//  ViewController.swift
//  movie
//
//  Created by ely.assumpcao.ndiaye on 22/05/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit
import CoreData

class SearchMovieVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchBoxText: UITextField!    
    @IBOutlet weak var movieCollection: UICollectionView!
    
    var favoriteBtnisSelected: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        movieCollection.delegate = self
        movieCollection.dataSource = self
        
        searchBtn.isHidden = true
        
        spinner.isHidden = true
        
        favoriteBtnisSelected = false
        
        let movie = MovieEntity()
        
        MovieServices.instance.findAllMovies { (success,errorMessage) in
            if success{
                self.movieCollection.reloadData()
            }
            else{
                let message = errorMessage
                print(message)
                self.EmptyTextField(text: "Pay Atention", message: message)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieServices.instance.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            let movie = MovieServices.instance.movies[indexPath.row]
            cell.configureCell(movie: movie)
            return cell
        }
        
        return MovieCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = MovieServices.instance.movies[indexPath.row]
        guard let detailMovieVC = storyboard?.instantiateViewController(withIdentifier: "DetailMovieVC") as? DetailMovieVC else { return }
        detailMovieVC.initData(title: movie.title, description: movie.overview, image: movie.poster_path, date: movie.release_date, geners: movie.genre_ids)
          presentDetail(detailMovieVC)
    }
    
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        if searchBoxText.text == "" {
            searchBtn.isHidden = true
        } else {searchBtn.isHidden = false }
    }
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        guard let searchTxt = searchBoxText.text , searchBoxText.text != "" else {
            EmptyTextField(text: "Preencha o campo Search", message: "O campo de busca deve ser preenchido")
            return }
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        MovieServices.instance.clearMovie()
        
        MovieServices.instance.findSearchMovies(query: searchTxt) { (success,errorMessage) in
            if success{
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                self.movieCollection.reloadData()
            }
            else{
                let message = errorMessage
                print(message)
                self.EmptyTextField(text: "Pay Atention", message: message)
            }
        }
    }
    
    @IBAction func FavoritesBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: TO_FAVORITES, sender: nil)
    }
    
    
    func EmptyTextField(text: String, message: String?){
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true) }
    
}

