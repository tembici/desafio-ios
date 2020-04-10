import RxSwift
import RxCocoa
import Alamofire

class API: ReactiveCompatible {}

extension Reactive where Base: API {
    
    static func getMoviesList(nextPageTrigger: Observable<Void>) -> Observable<Result<[Movie]>> {
        return getMoviesList(loadedSoFar: [], page: 1, nextPageTrigger: nextPageTrigger)
    }
    
    private static func getMoviesList(page: UInt) -> Observable<Result<[Movie]>> {
        return Observable.create { observer in
            Alamofire.request(R.string.movs.baseUrl(page.description), method: .get, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let values):
                    if let JSON = values as? [String: Any] {
                        let message = JSON["results"]
                        if let movies = try? JSONDecoder().decode([Movie].self, from: JSONSerialization.data(withJSONObject: message!, options: .prettyPrinted)) {
                            observer.onNext(.success(movies))
                            observer.onCompleted()
                        } else {
                            observer.onError(MovsError.parseError)
                            observer.onCompleted()
                        }
                    }
                case .failure:
                    observer.onError(MovsError.noConnection)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    static func getGenres() -> Observable<Result<[Genre]>> {
        return Observable.create { observer in
            Alamofire.request(R.string.movs.baseUrlGenres(), method: .get, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let values):
                    if let JSON = values as? [String: Any] {
                        let message = JSON["genres"]
                        if let movies = try? JSONDecoder().decode([Genre].self, from: JSONSerialization.data(withJSONObject: message!, options: .prettyPrinted)) {
                            observer.onNext(.success(movies))
                            observer.onCompleted()
                        } else {
                            observer.onError(MovsError.parseError)
                            observer.onCompleted()
                        }
                    }
                case .failure:
                    observer.onError(MovsError.noConnection)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    private static func getMoviesList(
       loadedSoFar: [Movie],
       page: UInt,
       nextPageTrigger: Observable<Void>
       ) -> Observable<Result<[Movie]>> {

       return getMoviesList(page: page)
           .flatMap { result -> Observable<Result<[Movie]>> in
               switch result {
               case .success(let movies):
                   var loadedNews = loadedSoFar
                   loadedNews.append(contentsOf: movies)
                   
                   guard movies.count != 0 else {
                       return Observable.just(Result.success(loadedNews))
                   }
                   
                   return Observable.concat([
                       Observable.just(Result.success(loadedNews)),
                       Observable.never().takeUntil(nextPageTrigger),
                       getMoviesList(loadedSoFar: loadedNews, page: (page + 1), nextPageTrigger: nextPageTrigger)
                       ])
                   
               case .failure:
                   return Observable.just(result)
               }
       }
    }

}
