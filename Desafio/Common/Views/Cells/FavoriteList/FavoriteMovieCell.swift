import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class FavoriteMovieCell: UITableViewCell {
    var moviePoster = UIImageView()
    var movieTitle = UILabel()
    var movieYearLabel = UILabel()
    var movieOverview = UILabel()

    var disposeBag = DisposeBag()
       
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupPosterImageView()
        setupTitleLabel()
        setupYearLabel()
        setupOverviewLabel()
    }
    
    private func setupPosterImageView() {
        addSubview(moviePoster)
        moviePoster.snp_makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
    }
    
    private func setupTitleLabel() {
        addSubview(movieTitle)
        movieTitle.snp_makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(moviePoster.snp.right).offset(8)
            make.right.equalToSuperview().inset(60)
            make.height.equalTo(20)
        }
    }
    
    private func setupYearLabel() {
        addSubview(movieYearLabel)
        movieYearLabel.snp_makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(20)
        }
    }
    
    private func setupOverviewLabel() {
        addSubview(movieOverview)
        movieOverview.numberOfLines = 4
        movieOverview.textAlignment = .justified
        movieOverview.snp_makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(8)
            make.left.equalTo(moviePoster.snp.right).offset(8)
            make.right.equalToSuperview().inset(8)
        }
    }
    
    var viewModel: FavoriteMovieViewModel! {
        didSet {
            bindViewModel()
        }
    }
    
    fileprivate func bindViewModel() {
        movieTitle.text = viewModel.movie.movieName
        movieOverview.text = viewModel.movie.overview
        movieYearLabel.text = String(viewModel.movie.releaseDate.prefix(4))
        if let movieURL = URL(string: R.string.movs.baseImageUrl(viewModel.movie.movieCoverURL)) {
            moviePoster.af_setImage(withURL: movieURL)
        }
    }
}
