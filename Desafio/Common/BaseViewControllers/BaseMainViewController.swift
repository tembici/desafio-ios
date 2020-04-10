import UIKit
import RxSwift
import RxCocoa

class BaseViewController<T: BaseMainView>: UIViewController {
    
    var mainView: T!
    let disposeBag = DisposeBag()
    
    lazy var alert: AlertRenderderAdapter = {
        return AlertRenderer(viewController: self)
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        mainView = T()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        mainView.setupProtocol = mainView
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupInputs()
        setupOutputs()
    }
    
    func setupInputs() {}
    func setupOutputs() {}
    
}
