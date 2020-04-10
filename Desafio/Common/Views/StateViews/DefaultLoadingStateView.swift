import UIKit
import SnapKit
import SpringIndicator

class DefaultLoadingStateView: UIView {
    
    enum LoadType {
        case opaque
        case translucid
    }

    private let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private let indicator = SpringIndicator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    
    private var loadType: LoadType!

    convenience init(loadType: LoadType) {
        self.init(frame: CGRect.zero)
        self.loadType = loadType
        setup()
    }

    private func setup() {
        indicator.lineWidth = 2
        indicator.lineColor = .blue
        indicator.start()
        indicatorContainer.addSubview(indicator)

        backgroundColor = loadType == .translucid ? UIColor.white.withAlphaComponent(0.7) : .white
        addSubview(indicatorContainer)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        indicatorContainer.snp.makeConstraints {make in
            make.height.equalTo(indicator.snp.height)
            make.width.equalTo(indicator.snp.width)
            make.center.equalTo(snp.center)
        }
    }
    
}
