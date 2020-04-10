import UIKit
import SnapKit

class SearchContainerView: UIView {
    var titleLabel = UILabel()
    var searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: Setup
    private func setup() {
        backgroundColor = Constants.backgroundYellowColor
        setupTitle()
        setupSearchBar()
    }
    
    private func setupTitle() {
        addSubview(titleLabel)
        titleLabel.text = R.string.movs.listTabTitle()
        titleLabel.snp_makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupSearchBar() {
        addSubview(searchBar)
        searchBar.layer.cornerRadius = 3
        searchBar.clipsToBounds = true
        searchBar.tintAdjustmentMode = .automatic
        searchBar.backgroundImage = UIImage()
        
        searchBar.placeholder = R.string.movs.searchPlaceholder()
        searchBar.snp_makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.width.equalToSuperview().inset(8)
            make.height.equalTo(38)
            make.centerX.equalToSuperview()
        }
    }
}
