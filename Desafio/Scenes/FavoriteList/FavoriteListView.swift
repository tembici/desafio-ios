import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FavoriteListView: BaseMainView {
    var searchContainer = SearchContainerView()
    var containerView = StatefulView()
    var tableView = UITableView()
    
    // MARK: Setup
    override func setup() {
        backgroundColor = UIColor.white
        setupSearchContainer()
        setupStateView()
    }
    
    private func setupSearchContainer() {
        addSubview(searchContainer)
        searchContainer.snp.makeConstraints { make in
            make.top.centerX.width.equalToSuperview()
            make.height.equalTo(120)
        }
    }
    
    private func setupStateView() {
        addSubview(containerView)
        containerView.snp_makeConstraints { make in
            make.top.equalTo(searchContainer.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func remakeTableConstraints() {
        containerView.addSubview(tableView)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.snp_makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview()
            make.right.left.equalToSuperview()
        }
    }
}
