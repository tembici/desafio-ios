import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class MovieCell: UICollectionViewCell {
	var movieTitle = UILabel()
	var moviePoster = UIImageView()
    var favoriteMovieImageView = UIImageView()
    var movie: Movie!
    var disposeBag = DisposeBag()
    var realmProvider: RealmProvider?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = Constants.backgroungDarkColor
        setupMoviePoster()
        setupFavoriteMovie()
		setupTitleLabel()
	}
    
    private func setupMoviePoster() {
        addSubview(moviePoster)
        moviePoster.contentMode = .scaleAspectFit
        moviePoster.snp_makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
    private func setupFavoriteMovie() {
        addSubview(favoriteMovieImageView)
        favoriteMovieImageView.contentMode = .scaleAspectFit
        favoriteMovieImageView.snp_makeConstraints { make in
            make.top.equalTo(moviePoster.snp.bottom).offset(2)
            make.right.equalToSuperview().inset(4)
            make.bottom.equalToSuperview()
            make.width.equalTo(22)
        }
    }
    
    private func setupTitleLabel() {
        addSubview(movieTitle)
        movieTitle.textColor = Constants.backgroundDarkYellowColor
        movieTitle.snp_makeConstraints { make in
            make.centerY.equalTo(favoriteMovieImageView.snp.centerY)
            make.left.equalToSuperview().offset(8)
            make.right.equalTo(favoriteMovieImageView.snp.left)
        }
    }
    
    private func setupSubscribers() {
        // swiftlint:disable force_try

        let movieRealm = try! FavoriteMovieDataSource(realmProvider: RealmProvider()).provider.loadRealm().object(ofType: RMFavoriteMovie.self, forPrimaryKey: movie.movieCoverURL)
        Observable
            .just(movieRealm)
            .subscribe(onNext: { [weak self] value in
            guard let this = self else { return }
                
            if value != nil {
                this.favoriteMovieImageView.image = R.image.ic_favorite_full()
            } else {
                this.favoriteMovieImageView.image = R.image.ic_favorite_gray()
            }
        }).disposed(by: disposeBag)
        
        favoriteMovieImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let this = self else { return }
            if this.favoriteMovieImageView.image == R.image.ic_favorite_gray() {
                this.favoriteMovieImageView.image = R.image.ic_favorite_full()
                try? FavoriteMovieDataSource(realmProvider: this.realmProvider!).saveMovie(movie: this.movie)
            } else {
                this.favoriteMovieImageView.image = R.image.ic_favorite_gray()
                try? FavoriteMovieDataSource(realmProvider: this.realmProvider!).removeMovie(movie: this.movie)
            }
        }).disposed(by: disposeBag)
    }
    
    var viewModel: MovieCellViewModel! {
        didSet {
			bindViewModel()
		}
    }
    
    fileprivate func bindViewModel() {
        movieTitle.text = viewModel.movie.movieName
        movie = viewModel.movie
        realmProvider = viewModel.realmProvider
        favoriteMovieImageView.image = R.image.ic_favorite_gray()
        if let movieURL = URL(string: R.string.movs.baseImageUrl(viewModel.movie.movieCoverURL)) {
            moviePoster.af_setImage(withURL: movieURL)
        }
        setupSubscribers()
	}

}
