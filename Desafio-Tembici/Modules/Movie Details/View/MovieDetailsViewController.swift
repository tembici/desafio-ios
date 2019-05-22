//
//  MovieDetailsViewController.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 19/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    var presenter: MovieDetailsPresenterInput?
    
    var display: MovieDetailsDisplay?
    
    var infoArray: [String?]{
        
        return [self.display?.title, self.display?.releaseYear, self.display?.sinopse]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        registerCells()
        
        self.presenter?.viewDidLoad()
    }
}

extension MovieDetailsViewController{
    
    private func setUpTableView(){
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
    }
    
    private func registerCells(){
        
            let generalNib = UINib(nibName: MovieDetailTableViewCell.defaultReuseIdentifier, bundle: nil)
            let titleNib = UINib(nibName: TitleTableViewCell.defaultReuseIdentifier, bundle: nil)
        
            detailsTableView.register(generalNib, forCellReuseIdentifier: MovieDetailTableViewCell.defaultReuseIdentifier)
        detailsTableView.register(titleNib, forCellReuseIdentifier: TitleTableViewCell.defaultReuseIdentifier)
    }
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if indexPath.row == 0{
            
            cell = createTitleCell(indexPath: indexPath)
        }
        else{
            cell = createSimpleCell(indexPath: indexPath)
        }
        
        return cell
    }
    
    private func createTitleCell(indexPath: IndexPath) -> UITableViewCell{
        
        let cell = self.detailsTableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! TitleTableViewCell
        
        guard let title = display?.title,
              let favorite = display?.favorite else{
            return UITableViewCell()
        }
        
        cell.configure(info: title, favorite: favorite)
        cell.delegate = self
        
        return cell
    }
    
    private func createSimpleCell(indexPath: IndexPath) -> UITableViewCell{
        
        let cell = self.detailsTableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! MovieDetailTableViewCell
        
        guard let info = infoArray[indexPath.row] else{
            return UITableViewCell()
        }
        cell.configure(detail: info)
        
        return cell
    }
}

extension MovieDetailsViewController: MovieDetailsPresenterOutput{
    
    func loadDetailsUI(details: MovieDetailsItem) {
        
        guard let display = MovieDetailsMapper.make(from: details) else{ return }
        
        self.display = display

        self.title = self.display?.title
        self.movieImageView.image = self.display?.posterImage
        self.detailsTableView.reloadData()
    }
}

extension MovieDetailsViewController: TitleTableViewCellDelegate{
    
    func favoriteButtonClicked() {
        
        self.presenter?.favoriteButtonClicked()
    }
}
