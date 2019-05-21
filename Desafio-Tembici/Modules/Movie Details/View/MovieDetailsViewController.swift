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
        
            detailsTableView.register(generalNib, forCellReuseIdentifier: MovieDetailTableViewCell.defaultReuseIdentifier)
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
        
        var cell: MovieDetailTableViewCell
        
        if indexPath.row == 0{
            
            cell = TitleTableViewCell()
            
            if let newCell = cell as? TitleTableViewCell{
                
                newCell.delegate = self
            }
        }
        else{
            
            cell = self.detailsTableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! MovieDetailTableViewCell
        }
        
        guard let info = infoArray[indexPath.row] else{ return UITableViewCell()}
       
        cell.configure(detail: info)
        
        return cell
    }
}

extension MovieDetailsViewController: MovieDetailsPresenterOutput{
    
    func loadDetailsUI(details: MovieDetailsItem) {
        
        guard let display = MovieDetailsMapper.make(from: details) else{ return }
        
        self.display = display
        print("info array ",self.infoArray.count)
        self.title = self.display?.title
        self.detailsTableView.reloadData()
    }
}

extension MovieDetailsViewController: TitleTableViewCellDelegate{
    
    func favoriteIconClicked() {
        
    }
}
