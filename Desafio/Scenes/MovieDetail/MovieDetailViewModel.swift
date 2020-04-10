import Foundation
import RxSwift
import RxCocoa

protocol MovieDetailViewModelInput {
    var didLoad: PublishSubject<Void> { get }
    var favoriteMovieAction: PublishSubject<Void> { get }
}

protocol MovieDetailViewModelOutput {
    var movieDetail: Driver<Movie> { get }
    var isFavorited: Driver<Bool> { get }
}

protocol MovieDetailViewModelProtocol: ViewModel {
    var inputs: MovieDetailViewModelInput { get }
    var outputs: MovieDetailViewModelOutput { get }
}

class MovieDetailViewModel: MovieDetailViewModelInput, MovieDetailViewModelProtocol {
    
    var inputs: MovieDetailViewModelInput { return self }
    var outputs: MovieDetailViewModelOutput { return self }
            
    private let coordinator: AppCoordinatorProcotol
    private var disposeBag = DisposeBag()
    
    var isMovieFavorited = false
    var didLoad = PublishSubject<Void>()
    var favoriteMovieAction = PublishSubject<Void>()

    private var movieSubject = PublishSubject<Movie>()
    private var favoriteSubject = PublishSubject<Bool>()

    init(movie: Movie, coordinator: AppCoordinatorProcotol, realmProvide: RealmProvider) {
        // swiftlint:disable force_try
        self.coordinator = coordinator
        
        didLoad.subscribe(onNext: { [weak self] _ in
            self?.movieSubject.onNext(movie)
            if FavoriteMovieDataSource(realmProvider: RealmProvider()).objectExist(id: movie.movieCoverURL) {
                self?.isMovieFavorited = true
                self?.favoriteSubject.onNext(self?.isMovieFavorited ?? false)
            }
        }).disposed(by: disposeBag)
        
        favoriteMovieAction.subscribe(onNext: { [weak self] _ in
            self?.isMovieFavorited = !(self?.isMovieFavorited ?? false)
            if self?.isMovieFavorited == false {
                try! FavoriteMovieDataSource(realmProvider: RealmProvider()).removeMovie(movie: movie)
            } else {
                try! FavoriteMovieDataSource(realmProvider: RealmProvider()).saveMovie(movie: movie)
            }
            self?.favoriteSubject.onNext(self?.isMovieFavorited ?? false)
        }).disposed(by: disposeBag)
    }
    
}

// MARK: MovieDetail ViewModelOutput
extension MovieDetailViewModel: MovieDetailViewModelOutput {
    var isFavorited: Driver<Bool> {
        return favoriteSubject.asDriver(onErrorJustReturn: false)
    }
    
    var movieDetail: Driver<Movie> {
        return movieSubject.asDriver(onErrorJustReturn: Movie(movieCoverURL: "", movieName: "", releaseDate: "", genreIds: [], overview: "", genres: []))
    }
}
