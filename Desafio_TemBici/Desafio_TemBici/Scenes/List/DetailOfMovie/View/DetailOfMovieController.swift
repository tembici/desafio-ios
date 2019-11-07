// 
//  DetailOfMovieController.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class DetailOfMovieController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var viewError: UIView!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    //MARK: PROPERTIES
    lazy var presenter: DetailOfMoviePresenter = {
        let p = DetailOfMoviePresenter(view: self, router: DetailOfMovieRouter(self))
        return p
    }()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    //MARK: NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(segue: segue, sender: sender)
    }
    
}

//MARK: DetailOfMovieView
extension DetailOfMovieController: DetailOfMovieView {
    
    func display(detailModel: DetailModel) {
        DispatchQueue.main.async { [weak self] in
            self?.viewError.isHidden = true
            self?.movieImage.image = detailModel.movieImage
            self?.movieName.text = detailModel.movieName
            self?.movieYear.text = detailModel.getDate()
            self?.movieGenre.text = detailModel.getGenres()
            self?.movieOverview.text = detailModel.movieOverview
        }
    }
    
    func error(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.labelError.text = message
            self?.viewError.isHidden = false
        }
    }
    
}
