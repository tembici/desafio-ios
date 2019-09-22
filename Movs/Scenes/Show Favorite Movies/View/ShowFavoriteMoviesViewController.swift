//
//  ShowFavoriteMoviesViewController.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol ShowFavoriteMoviesDisplayLogic: class {
  func displayFavoriteMovies(viewModel: ShowFavoriteMovies.FetchFavoriteMovies.ViewModel)
}

class ShowFavoriteMoviesViewController: UIViewController, ShowFavoriteMoviesDisplayLogic {
    var interactor: ShowFavoriteMoviesBusinessLogic?
    var router: (NSObjectProtocol & ShowFavoriteMoviesRoutingLogic & ShowFavoriteMoviesDataPassing)?

    // MARK: Object lifecycle

    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ShowFavoriteMoviesInteractor()
        let presenter = ShowFavoriteMoviesPresenter()
        let router = ShowFavoriteMoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFavoriteMovies()
    }

    func fetchFavoriteMovies() {
        let request = ShowFavoriteMovies.FetchFavoriteMovies.Request()
        interactor?.fetchFavoriteMovies(request: request)
    }

    func displayFavoriteMovies(viewModel: ShowFavoriteMovies.FetchFavoriteMovies.ViewModel) {

    }
}
