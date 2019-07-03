//
//  MovieViewController.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import UIKit

protocol MovieDisplayLogic: class {
    func display(viewModel: MovieModels.GetMovie.ViewModel)
}

class MovieViewController: UIViewController, MovieDisplayLogic {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var yearLabel: UILabel!
    @IBOutlet private var genresLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    var interactor: MovieInteractorProtocol?
    var router: MovieRouterProtocol?
    
    private func setup() {
        let viewController = self
        let interactor = MovieInteractor()
        let presenter = MoviePresenter()
        let router = MovieRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor?.get(request: MovieModels.GetMovie.Request())
    }
    
    func display(viewModel: MovieModels.GetMovie.ViewModel) {
        self.titleLabel.text = viewModel.displayedMovie.title
        self.yearLabel.text = viewModel.displayedMovie.year
        self.genresLabel.text = viewModel.displayedMovie.genre
        self.descriptionLabel.text = viewModel.displayedMovie.description
    }
    
}
