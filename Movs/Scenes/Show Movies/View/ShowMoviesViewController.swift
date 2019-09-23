//
//  ShowMoviesViewController.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol ShowMoviesDisplayLogic: class {
  func displayMovies(viewModel: ShowMovies.fetchMovies.ViewModel)
}

class ShowMoviesViewController: UIViewController {
    
    var content = [Any]()
    
    var interactor: ShowMoviesBusinessLogic?
    var router: (NSObjectProtocol & ShowMoviesRoutingLogic & ShowMoviesDataPassing)?
    var alert: FilterAlertViewController!
    
    // MARK: - Outlets
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        self.present(self.alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.register(MovieCollectionViewCell.self)
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
    
    private lazy var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
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
        self.alert = FilterAlertViewController(delegate: self)
        self.setupLayout()
        self.fetchMovies()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ShowMoviesInteractor()
        let presenter = ShowMoviesPresenter()
        let router = ShowMoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupLayout() {
        self.navigationItem.searchController = searchController
        let font = UIFont.getExoFont(type: .semiBold, with: 20)
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: Private Methods

    private func fetchMovies() {
        let request = ShowMovies.fetchMovies.Request()
        interactor?.fetchData(request: request)
    }
    
    private func favoriteMovie(content: Any) {
        if let movie = content as? Movie {
            let request = ShowMovies.favoriteMovie.Request(movie: movie)
            self.interactor?.setAsFavorite(request: request)
        }
    }
    
    private func routeToMovieDetails(data: Any) {
        if let movie = data as? Movie {
            self.router?.routeToMovieDetail(movieId: movie.id)
        }
    }
}

// MARK: - Display Logic -

extension ShowMoviesViewController: ShowMoviesDisplayLogic {

    func displayMovies(viewModel: ShowMovies.fetchMovies.ViewModel) {
        DispatchQueue.main.async {
            self.content += viewModel.content
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Collection View Delegate -

extension ShowMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.routeToMovieDetails(data: self.content[indexPath.row])
    }
}

// MARK: - Collection View DataSource -

extension ShowMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier,
                                                      for: indexPath) as! MovieCollectionViewCell
        cell.setup(with: content[indexPath.row], delegate: self)
        
        return cell
    }
}

// MARK: - MovieCollectionViewCellDelegate -

extension ShowMoviesViewController: MovieCollectionViewCellDelegate {
    
    func didSelectFavorite(for movie: Movie?) {
        if let movie = movie  {
            self.favoriteMovie(content: movie)
        }
    }
}

// MARK: -

extension ShowMoviesViewController: FilterAlertDelegate{
   
    func dismissAlert() {
        self.alert.dismiss(animated: true, completion: nil)
    }
    
    func filterRequested(for value: Any) {
        if let s = value as? String {
            print(s)
        }
    }
}

