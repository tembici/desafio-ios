import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt
import RxSwiftUtilities

extension ActivityIndicator {
    
    func toLoadingState<T>(observableResult: Observable<Result<T>>, stopAtFirstResult: Bool = false) -> Observable<LoadingState> {
        
        let isLoading = self.asObservable()
        
        let startLoading = isLoading
            .filter({ $0 })
            .map({ _ in LoadingState(isLoading: true) })
        
        let stopLoading: Observable<LoadingState>
        
        if stopAtFirstResult {
            stopLoading = observableResult
                .flatMap { (result: Result<T>) -> Observable<LoadingState> in
                    return Observable.just(
                        LoadingState(isLoading: false, error: result.failure?.error)
                    )
            }
            
        } else {
            stopLoading = isLoading
                .filter({ !$0 })
                .withLatestFrom(
                    observableResult
                )
                .asObservable()
                .flatMap { (result: Result<T>) -> Observable<LoadingState> in
                    return Observable.just(
                        LoadingState(isLoading: false, error: result.failure?.error)
                    )
            }
        }
        
        return Observable.of(startLoading, stopLoading)
            .merge()
    }
}
