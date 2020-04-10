import UIKit
import RxSwift
import RxCocoa

class SearchContainerViewController: UIViewController {
    private var mainView = SearchContainerView()
    
    let disposeBag = DisposeBag()
    
    // MARK: Init
    init(tabView: UITabBarController) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = mainView
    }

}
