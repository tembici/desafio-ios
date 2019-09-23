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

class ShowFavoriteMoviesViewController: UIViewController {
   
    var content = [Any]()
    
    var interactor: ShowFavoriteMoviesBusinessLogic?
    var router: (NSObjectProtocol & ShowFavoriteMoviesRoutingLogic & ShowFavoriteMoviesDataPassing)?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.register(FavoriteMovieTableViewCell.self)
            self.tableView.dataSource = self
        }
    }
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        self.fetchFavoriteMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchFavoriteMovies()
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

    private func setupLayout() {
        let font = UIFont.getExoFont(type: .semiBold, with: 20)
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
  
    private func fetchFavoriteMovies() {
        let request = ShowFavoriteMovies.FetchFavoriteMovies.Request()
        interactor?.fetchFavoriteMovies(request: request)
    }
}

extension ShowFavoriteMoviesViewController: ShowFavoriteMoviesDisplayLogic {
    
    func displayFavoriteMovies(viewModel: ShowFavoriteMovies.FetchFavoriteMovies.ViewModel) {
        DispatchQueue.main.async {
            self.content = viewModel.content
            self.tableView.reloadData()
        }
    }
}

extension ShowFavoriteMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieTableViewCell.identifier,
                                                       for: indexPath) as? FavoriteMovieTableViewCell
        else { return UITableViewCell() }
        cell.setup(with: content[indexPath.row], delegate: self)
        
        return cell
    }
}

extension ShowFavoriteMoviesViewController: FavoriteMovieTableViewCellDelegate {
    
    func didSelectFavorite(for movie: Movie?) {
        
    }
}
