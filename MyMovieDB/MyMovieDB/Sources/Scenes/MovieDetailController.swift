//
//  MovieDetailController.swift
//  MyMovieDB
//
//  Created by Chrystian Salgado on 28/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit
import JGProgressHUD

class MovieDetailController: UIViewController {
    
    @IBOutlet weak var contentView: MovieDetailContentView!
    
    var movie: MovieResult?
    private let loadingView: JGProgressHUD = JGProgressHUD(style: .light)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.delegate = self
        requestMovieDetail()
    }
    
    private func requestMovieDetail() {
        loadingView.show(in: self.view)
        Manager().requestDetail(param: "\(movie?.id ?? 0)"){ (movieResponse, error) in
            if let _movieResponse = movieResponse {
                self.movie = _movieResponse
            } else if let _error = error {
                self.display(errorAlert(error: _error))
                Logger().log(_error.localizedDescription)
            }
            self.loadingView.dismiss()
            self.updateFavorite()
            self.configureUI()
        }
    }
    
    private func display(_ alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    private func configureUI() {
        title = movie?.title ?? NSLocalizedString("MOVIE_DETAIL_TITLE", comment: "")
        contentView.displayUI(movie: movie)
    }
    
    private func updateFavorite() {
        do {
            if let favoriteMovies = try CoreDataHelper().getData(in: Entitys.Movie), let _movie = self.movie {
                for favorited in favoriteMovies {
                    if _movie.id == favorited.value(forKey: "id") as! Int {
                        self.movie?.favorite = (favorited.value(forKey: "favorite") as! Bool)
                    }
                }
            }
        } catch {
            // ...
        }
    }
}

extension MovieDetailController: MovieDetailViewDelegate {
    
    func handlerActionFavorite(favorite: Bool) {
        movie?.favorite = favorite
        guard let movieManagedObject = self.movie?.toNSManagedObject() else { return }

        do {
            if try CoreDataHelper().saveSingleObject(object: movieManagedObject) {
                self.configureUI()
            }
        } catch {
            // ...
        }
    }
}
