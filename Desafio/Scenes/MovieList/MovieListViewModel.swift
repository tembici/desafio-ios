import Foundation
import RxSwift
import RxCocoa

protocol MovieListPresenterLogic {
}

protocol MovieListViewModelInput {
    var didLoad: PublishSubject<Void> { get }
    var reload: PublishSubject<Void> { get }
    var changedText: PublishSubject<String> { get }
    var nextPage: PublishSubject<Void> { get }
    var movieSelected: PublishSubject<MovieCellViewModel> { get }
}

protocol MovieListViewModelOutput {
    var menuItems: Driver<[SectionViewModelType<MovieCellViewModel>]> { get }
    var genres: Driver<[Genre]> { get }
    var listState: Driver<ViewState> { get }
    var pagingLoading: Driver<Bool> { get }
}

protocol MovieListViewModelProtocol: ViewModel {
    var inputs: MovieListViewModelInput { get }
    var outputs: MovieListViewModelOutput { get }
}

struct MovieListViewModel: MovieListViewModelInput, MovieListViewModelProtocol {
       
    var inputs: MovieListViewModelInput { return self }
    var outputs: MovieListViewModelOutput { return self }
    
    // MARK: MovieList ViewModelInput
    let didLoad = PublishSubject<Void>()
    let reload = PublishSubject<Void>()
    let nextPage = PublishSubject<Void>()
    let changedText = PublishSubject<String>()
    let movieSelected = PublishSubject<MovieCellViewModel>()

    // MARK: Variables
    private var moviesItemsBehaviorRelay = BehaviorRelay<[SectionViewModelType<MovieCellViewModel>]>(value: [])
    private var moviesObservableResult: Observable<Result<[Movie]>>
    
    private var genresBehaviorRelay = BehaviorRelay<[Genre]>(value: [])
    private var genresObservableResult: Observable<Result<[Genre]>>
    
    private var activityIndicator: ActivityIndicator
    private var disposeBag = DisposeBag()
    
    // MARK: Init
    init(coordinator: AppCoordinator) {
        let indicator = ActivityIndicator()
        self.activityIndicator = indicator
        let pageTriggerObservable = nextPage.asObservable()

        moviesObservableResult = Observable.merge(didLoad, reload).flatMap({ _ in
            return API.rx.getMoviesList(nextPageTrigger: pageTriggerObservable).trackActivity(indicator)
        }).share()
        
        genresObservableResult = didLoad.flatMap({ _ in
            return API.rx.getGenres().trackActivity(indicator)
        }).share()
        
        movieSelected.subscribe(onNext: { movie in
            coordinator.route(to: AppPath.detail(movie: movie.movie))
        }).disposed(by: disposeBag)

        genresObservableResult
            .map { $0.value }
            .unwrap()
            .bind(to: genresBehaviorRelay)
            .disposed(by: disposeBag)
        
        moviesObservableResult.map { $0.failure }
            .unwrap().map { ($0, nil) }
            .bind(to: ApiErrorHandler.sharedInstance.rx.handleError)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(moviesObservableResult.map { $0.value }.unwrap(), genresObservableResult.map { $0.value}.unwrap() )
        .map { movies, genre in
            let movieList = movies.map { (movie) -> Movie in
                let genreList = genre.filter({ movie.genreIds.contains($0.id) })
                return Movie(movieCoverURL: movie.movieCoverURL, movieName: movie.movieName, releaseDate: movie.releaseDate, overview: movie.overview, genres: genreList)
            }
            return [SectionViewModelType<MovieCellViewModel>(viewModels: movieList.map {
                MovieCellViewModel(movie: $0, realmProvider: coordinator.realmProvider)})]
        }
        .bind(to: moviesItemsBehaviorRelay).disposed(by: disposeBag)

        genresObservableResult.map { $0.failure }
            .unwrap().map { ($0, nil) }
            .bind(to: ApiErrorHandler.sharedInstance.rx.handleError)
            .disposed(by: disposeBag)
        
    }
    
}

// MARK: MovieList ViewModelOutput
extension MovieListViewModel: MovieListViewModelOutput {
    var genres: Driver<[Genre]> {
        return genresBehaviorRelay.asDriver(onErrorJustReturn: [])
    }
    
    var pagingLoading: Driver<Bool> {
        return activityIndicator.asDriver()
    }
    
    var menuItems: Driver<[SectionViewModelType<MovieCellViewModel>]> { return moviesItemsBehaviorRelay.asDriver() }

    var listState: Driver<ViewState> {
        let loading = activityIndicator.toLoadingState(observableResult: moviesObservableResult)
      
        return loading
            .map { result -> ViewState in
               return result.isLoading ? ViewState.loading : ViewState.none
        }.asDriver(onErrorJustReturn: .none)
    }
}
