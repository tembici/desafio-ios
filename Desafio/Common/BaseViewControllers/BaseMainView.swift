import UIKit
import SnapKit

protocol BaseMainViewProtocol: UIView {
    func setup()
}

class BaseMainView: UIView, BaseMainViewProtocol {
    
    weak var setupProtocol: BaseMainViewProtocol? {
        didSet {
            layoutIfNeeded()
            setupProtocol?.setup()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setup() {}
}
