import Foundation
import RxSwift
import RxCocoa

extension AlertRenderer: ReactiveCompatible {}

extension Reactive where Base: AlertRenderer {
    
    var alertOptions: Binder<AlertOptions> {
        return Binder(self.base) { control, options in
            control.showAlert(options: options, completion: nil)
        }
    }
}
