import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MovieListViewController: BaseViewController<MovieListView> {
    private var viewModel: MovieListViewModelProtocol!
    private let dataSource = RxCollectionViewSectionedReloadDataSource<SectionViewModelType<MovieCellViewModel>>(configureCell: { _, _, _, _ -> UICollectionViewCell in
        return UICollectionViewCell()
    })
    
    // MARK: Init
    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.remakeCollectionConstraints()
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.containerView
            .setAvailableViews(loadingView: DefaultLoadingStateView(loadType: .opaque),
                               errorView: DefaultErrorStateView(title: "Erro", subtitle: "Tente novamente"),
                               emptyView: DefaultEmptyStateView(title: "Opa", subtitle: "não há resultados")
        )
        let reloadAction: (() -> Void) = { [weak self] in self?.viewModel.inputs.reload.onNext(()) }
        mainView.containerView.setHandlers(errorView: reloadAction, emptyView: reloadAction)       

        viewModel
            .inputs
            .didLoad
            .onNext(())
    }
    
    // MARK: Setup
    override func setupInputs() {
        mainView
            .collectionView
            .rx
            .didEndDecelerating
            .bind(to: viewModel.inputs.nextPage)
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx
            .modelSelected(MovieCellViewModel.self)
            .bind(to: viewModel.inputs.movieSelected)
            .disposed(by: disposeBag)
    }
    
    override func setupOutputs() {
        let identifier = String(describing: MovieCell.self)
        mainView.collectionView.register(MovieCell.self, forCellWithReuseIdentifier: identifier)
        dataSource.configureCell = {  _, collectionView, indexPath, viewModel in
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCell)!
            cell.viewModel = viewModel
            return cell
        }
        
        viewModel.outputs.menuItems
            .drive(mainView.collectionView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
        
        viewModel.outputs.listState.drive(mainView.containerView.rx.state).disposed(by: disposeBag)
        
    }
    
}
