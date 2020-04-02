import RxCocoa
import RxSwift
import StatefulViewController

extension Reactive where Base: StatefulViewController {
    
    var isLoading: Binder<LoadingState> {
        return Binder(self.base) { control, value in
            value.isLoading ? control.startLoading() : control.endLoading(error: value.error)
        }
    }
}
