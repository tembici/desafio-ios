import Foundation
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

protocol FavoriteListPresenterLogic {
}

protocol FavoriteListViewModelInput {
    var didLoad: PublishSubject<Void> { get }
    var itemDeleted: PublishSubject<FavoriteMovieViewModel> { get }
}

protocol FavoriteListViewModelOutput {
    var tableItems: Driver<[SectionViewModelType<FavoriteMovieViewModel>]> { get }
}

protocol FavoriteListViewModelProtocol: ViewModel {
    var inputs: FavoriteListViewModelInput { get }
    var outputs: FavoriteListViewModelOutput { get }
}

struct FavoriteListViewModel: FavoriteListViewModelInput, FavoriteListViewModelProtocol {
    var itemDeleted = PublishSubject<FavoriteMovieViewModel>()
    
    var inputs: FavoriteListViewModelInput { return self }
    var outputs: FavoriteListViewModelOutput { return self }
    
    // MARK: FavoriteList ViewModelInput
    let didLoad = PublishSubject<Void>()
    
    // MARK: Variables
    private var moviesItemsBehaviorRelay = BehaviorRelay<[SectionViewModelType<FavoriteMovieViewModel>]>(value: [])
    private var disposeBag = DisposeBag()
    
    // MARK: Init
    init(realmProvider: RealmProvider) {
        // swiftlint:disable force_try
        let movies = try! realmProvider.loadRealm().objects(RMFavoriteMovie.self)
        
        Observable.changeset(from: movies)
            .asObservable()
            .map { $0.0 }
            .map { $0.toArray() }
            .map { itens in
            let movieList = itens.map { $0.entity }
            return [SectionViewModelType<FavoriteMovieViewModel>(viewModels: movieList.map { return FavoriteMovieViewModel(movie: $0)})]
            }
        .bind(to: moviesItemsBehaviorRelay)
        .disposed(by: disposeBag)
        
        itemDeleted.subscribe(onNext: { movie in
            try! FavoriteMovieDataSource(realmProvider: realmProvider).removeMovie(movie: movie.movie)
        }).disposed(by: disposeBag)
        
    }
    
}

// MARK: FavoriteList ViewModelOutput
extension FavoriteListViewModel: FavoriteListViewModelOutput {
    var tableItems: Driver<[SectionViewModelType<FavoriteMovieViewModel>]> { return moviesItemsBehaviorRelay.asDriver() }
}
