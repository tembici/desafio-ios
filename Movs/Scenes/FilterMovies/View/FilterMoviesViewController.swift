//
//  SearchMoviesViewController.swift
//  Movs
//
//  Created by Miguel Pimentel on 24/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit
import AVKit

protocol FilterMoviesDisplayLogic: class {
    func displayMovies(viewModel: FilterMovies.FilterByGenre.ViewModel)
    func displayGenres(viewModel: FilterMovies.FetchGenders.ViewModel)
}

class FilterMoviesViewController: UIViewController {
    
    var interactor: FilterMoviesBusinessLogic?
    var router: (NSObjectProtocol & SearchMoviesRoutingLogic & SearchMoviesDataPassing)?
    
    fileprivate var viewParams = FilterMovies.ViewController.Params(section: 0,
                                                                    page: 1,
                                                                    genderId: 248,
                                                                    title: "Categories")
    fileprivate var collectionViewContent = [Any]()
    fileprivate var tableViewContent = [Any]()
    
    // MARK: Outlet
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.register(GenreCollectionViewCell.self)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource  = self
            self.tableView.register(FavoriteMovieTableViewCell.self)
        }
    }
    // MARK: Object Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.fetchGenres()
    }

    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = FilterMoviesInteractor()
        let presenter = FilterMoviesPresenter()
        let router = FilterMoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupLayout() {
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtton
        self.navigationItem.title = self.viewParams.title
    }
    
    private func fetchGenres() {
        let request = FilterMovies.FetchGenders.Request()
        self.interactor?.fetchGenders(request: request)
    }
    
    private func setForceTouchCapability(tableView: UITableView?) {
        if self.traitCollection.forceTouchCapability == .available {
        }
    }
    
    // MARK: Private Methods
    
    func requestMovie(by genreId: Int, page: Int) {
        let request = FilterMovies.FilterByGenre.Request(genreId: genreId, page: page)
        self.interactor?.fetchMoviesByGenre(request: request)
    }
}

extension FilterMoviesViewController: FilterMoviesDisplayLogic {
    
    func displayGenres(viewModel: FilterMovies.FetchGenders.ViewModel) {
        DispatchQueue.main.async {
            self.collectionViewContent = viewModel.content
            self.collectionView.reloadData()

            if let genre = viewModel.content.first as? Genre {
                self.viewParams.genderId = genre.id
                self.requestMovie(by: self.viewParams.genderId, page: self.viewParams.page)
            }
        }
    }
    
    func displayMovies(viewModel: FilterMovies.FilterByGenre.ViewModel) {
        DispatchQueue.main.async {
            self.tableViewContent = viewModel.content
            self.tableView.reloadData()
        }
    }
}

extension FilterMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier,
                                                      for: indexPath) as! GenreCollectionViewCell
        cell.setup(with: collectionViewContent[indexPath.item])
        
        return cell
    }
}

extension FilterMoviesViewController:  UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let genre = collectionViewContent[indexPath.item] as? Genre {
            self.requestMovie(by: genre.id, page: viewParams.page)
        }
        
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension FilterMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieTableViewCell.identifier,
                                                       for: indexPath) as? FavoriteMovieTableViewCell
            else { return UITableViewCell() }
        cell.setup(with: self.tableViewContent[indexPath.row], delegate: self)
        
        return cell
    }
}

extension FilterMoviesViewController: FavoriteMovieTableViewCellDelegate {
    
    func didSelectFavorite(for movie: Movie?) {
        
    }
}

extension FilterMoviesViewController: UITableViewDelegate {
    
}
