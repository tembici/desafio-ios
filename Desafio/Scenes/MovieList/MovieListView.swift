import UIKit
import SnapKit

class MovieListView: BaseMainView {
    var searchContainer = SearchContainerView()
    var containerView = StatefulView()
    
    var collectionView: UICollectionView = {
         UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    }()

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

    func remakeCollectionConstraints() {
        containerView.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.snp_makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview()
            make.right.left.equalToSuperview().inset(8)
        }
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let padding = 15
            let width = (UIScreen.main.bounds.width - CGFloat(padding) * 2) / CGFloat(2)
            let height = CGFloat(300)
            flowLayout.itemSize = CGSize(width: width, height: height)
        }
    }
}
