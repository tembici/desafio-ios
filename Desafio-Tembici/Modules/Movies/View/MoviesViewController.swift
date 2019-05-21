//
//  MoviesViewController.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var presenter: MoviesPresenter?
    
    var moviesDisplay: [MovieDisplay] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setUpNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCell()
        self.setUpNavigation()
        self.setUpCollectionView()
        
        presenter?.viewDidLoad()
    }
}

extension MoviesViewController{
    
    private func registerCell(){
        
        let nib = UINib(nibName: MovieCollectionViewCell.defaultReuseIdentifier, bundle: nil)
        moviesCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.defaultReuseIdentifier)
    }
    
    private func setUpCollectionView(){
        
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
        
        
        guard let layout = self.moviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
            else{

            return
        }
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
    
    private func setUpNavigation(){
        
        self.tabBarController?.title = "Movies"
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        let movie = moviesDisplay[indexPath.item]
        
        cell.movieDisplay = movie
        cell.configure()
        cell.delegate = self
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: moviesCollectionView.bounds.width * 0.45, height: moviesCollectionView.bounds.width * 0.45)
    }
}

extension MoviesViewController: MoviesPresenterOutput{
    
    func loadUIMovies(items: [MovieItem]) {
        
        self.moviesDisplay = []
        
        for item in items{
            guard let displayItem = MovieMapper.make(from: item) else{
                return
            }
            self.moviesDisplay.append(displayItem)
        }
        self.moviesCollectionView.reloadData()
    }
}

extension MoviesViewController: MovieCollectionViewCellDelegate{
    
    func favoriteButtonClicked(id: Int) {
        
//        guard let index = self.moviesDisplay.firstIndex(where: {$0.id == id}) else{
//            return
//        }
//        guard let favorite = self.moviesDisplay[index].favorite else{
//            return
//        }
//        
//        moviesDisplay[index].favorite = !favorite
        
        self.presenter?.favoriteButtonClicked(id: id)
    }
    
    func didSelect(id: Int) {
        
        self.presenter?.didSelect(id: id)
    }
}

