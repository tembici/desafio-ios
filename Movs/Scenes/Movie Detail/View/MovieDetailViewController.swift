//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit
import AVKit

protocol MovieDetailDisplayLogic: class {
    func displayMovieDetails(viewModel: MovieDetail.FetchMovieDetails.ViewModel)
    func displayVideos(viewModel: MovieDetail.FetchMovieVideos.ViewModel)
}

class MovieDetailViewController: UIViewController, MovieDetailDisplayLogic {
    
    // MARK: Variables
    
    var contentData = [Any]()
    
    var interactor: MovieDetailBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailRoutingLogic & MovieDetailDataPassing)?
    
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.dataSource = self
            self.collectionView.register(MovieVideosCollectionViewCell.self)
        }
    }
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieLanguageLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var movieLengthLabel: UILabel!
    
    // MARK: Actions
    

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
        self.fetchMovieDetails()
    }
    
    // MARK: - Setup -
    
    private func setup() {
        let viewController = self
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        let router = MovieDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupLayout() {
        self.navigationItem.title = "Details"
        self.navigationController?.navigationBar.tintColor = UIColor(named: "primaryGray") ?? .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(shareImage))
    }
    

    // MARK: Display Logic
    
    func displayMovieDetails(viewModel: MovieDetail.FetchMovieDetails.ViewModel) {
        DispatchQueue.main.async {
            self.movieTitleLabel.text = viewModel.movieTitle
            self.movieOverviewLabel.text = viewModel.movieOverview
            self.moviePosterImageView.cacheImage(urlString: viewModel.moviePosterUrl)
            self.movieRateLabel.text = viewModel.movieRate
            self.movieYearLabel.text = viewModel.movieReleaseYear
            self.movieLengthLabel.text = viewModel.movieLength
            self.movieLanguageLabel.text = viewModel.movieLanguage
        }
        
         self.fetchMovieVideos()
    }
    
    func displayVideos(viewModel: MovieDetail.FetchMovieVideos.ViewModel) {
        DispatchQueue.main.async {
            self.contentData = viewModel.content
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Private Methods
    
    private func fetchMovieDetails() {
        if let movieId = router?.dataStore?.movieId {
            let request = MovieDetail.FetchMovieDetails.Request(movieId: movieId)
            self.interactor?.fetchMovieDetails(request: request)
        }
    }
    
    private func fetchMovieVideos() {
        if let movieId = router?.dataStore?.movieId {
            let request = MovieDetail.FetchMovieVideos.Request(movieId: movieId)
            self.interactor?.fetchMovieVideos(request: request)
        }
    }
    
    @objc private func shareImage(){
        guard let image = self.moviePosterImageView.image else { return }
        let imageShare = [image]
        
        let activityViewController = UIActivityViewController(activityItems: imageShare,
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieVideosCollectionViewCell.identifier,
                                                      for: indexPath) as! MovieVideosCollectionViewCell
        cell.setup(with: contentData[indexPath.item])
        
        return cell
    }
}
