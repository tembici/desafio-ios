import UIKit
import RxSwift
import RxCocoa

class MovieDetailViewController: BaseViewController<MovieDetailView> {
    private var viewModel: MovieDetailViewModelProtocol!

    // MARK: Init
    init(viewModel: MovieDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputs.didLoad.onNext(())
    }
    
    // MARK: Setup
    override func setupInputs() {
        mainView.favoriteMovie.rx.tapGesture().when(.recognized).map { _ in ()}.bind(to: viewModel.inputs.favoriteMovieAction).disposed(by: disposeBag)
    }
    
    override func setupOutputs() {
        viewModel.outputs.movieDetail.drive(onNext: { [weak self] movie in
            guard let this = self else { return }
            if let url = URL(string: R.string.movs.baseImageUrl(movie.movieCoverURL)) {
                this.mainView.posterImageView.af_setImage(withURL: url)
            }
            this.mainView.movieNameLabel.text = movie.movieName
            var genres = ""
            for (index, genre) in movie.genres.enumerated() {
                if index == movie.genres.count-1 {
                    genres.append(genre.name)
                } else {
                    genres.append(genre.name + ", ")
                }
            }
            this.mainView.genres.text = genres
            this.mainView.releaseYear.text = String(movie.releaseDate.prefix(4))
            this.mainView.overviewLabel.text = movie.overview
        }).disposed(by: disposeBag)
        
        viewModel
            .outputs
            .isFavorited
            .drive(onNext: { [weak self] isFavorite in
                self?.mainView.rx.changeFavorited.onNext(isFavorite)
            })
            .disposed(by: disposeBag)
    }
}
