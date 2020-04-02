import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MovieDetailView: BaseMainView {
    
    var posterImageView = UIImageView()
    var movieNameLabel = UILabel()
    var favoriteMovie = UIImageView()
    var separatorView = UIView()
    var releaseYear = UILabel()
    var secondSeparatorView = UIView()
    var genres = UILabel()
    var thirdSeparatorView = UIView()
    var overviewLabel = UILabel()
    
    // MARK: Setup
    override func setup() {
        super.setup()
        backgroundColor = .white
        setupPoster()
        setupMovieTitle()
        setupFavoriteMovie()
        setupFirstSeparatorView()
        setupReleaseYearLabel()
        setupSecondSeparatorView()
        setupGenresLabel()
        setupThirdSeparatorView()
        setupOverviewLabel()
    }
    
    private func setupPoster() {
        addSubview(posterImageView)
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.snp_makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
    }
    
    private func setupMovieTitle() {
        addSubview(movieNameLabel)
        movieNameLabel.snp_makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
    }
    
    private func setupFavoriteMovie() {
        addSubview(favoriteMovie)
        favoriteMovie.contentMode = .center
        favoriteMovie.image = R.image.ic_favorite_empty()
        favoriteMovie.snp_makeConstraints { make in
            make.centerY.equalTo(movieNameLabel.snp.centerY)
            make.right.equalToSuperview().inset(8)
            make.width.height.equalTo(20)
        }
    }
    
    private func setupFirstSeparatorView() {
        addSubview(separatorView)
        separatorView.backgroundColor = .gray
        separatorView.snp_makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(6)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func setupReleaseYearLabel() {
        addSubview(releaseYear)
        releaseYear.snp_makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.height.equalTo(40)
        }
    }
    
    private func setupSecondSeparatorView() {
        addSubview(secondSeparatorView)
        secondSeparatorView.backgroundColor = .gray
        secondSeparatorView.snp_makeConstraints { make in
            make.top.equalTo(releaseYear.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(6)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func setupGenresLabel() {
        addSubview(genres)
        genres.text = "ação"
        genres.snp_makeConstraints { make in
            make.top.equalTo(secondSeparatorView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.height.equalTo(40)
        }
    }
    
    private func setupThirdSeparatorView() {
        addSubview(thirdSeparatorView)
        thirdSeparatorView.backgroundColor = .gray
        thirdSeparatorView.snp_makeConstraints { make in
            make.top.equalTo(genres.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(6)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func setupOverviewLabel() {
        addSubview(overviewLabel)
        overviewLabel.textAlignment = .justified
        overviewLabel.numberOfLines = 5
        overviewLabel.snp_makeConstraints { make in
            make.top.equalTo(thirdSeparatorView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(8)
        }
    }
}

extension Reactive where Base: MovieDetailView {
    var changeFavorited: Binder<Bool> {
        return Binder(self.base) { base, value in
            if value {
                base.favoriteMovie.image = R.image.ic_favorite_full()
            } else {
                base.favoriteMovie.image = R.image.ic_favorite_empty()
            }
        }
    }
}
