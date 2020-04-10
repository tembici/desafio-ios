import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class FavoriteListViewController: BaseViewController<FavoriteListView> {
    private var viewModel: FavoriteListViewModelProtocol!
    private let moviesDataSource = RxTableViewSectionedReloadDataSource<SectionViewModelType<FavoriteMovieViewModel>>(
        configureCell: {_, _, _, _ in return UITableViewCell() },
        canEditRowAtIndexPath: { _, _  -> Bool in
            return true
        }
    )
    
    // MARK: Init
    init(viewModel: FavoriteListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputs.didLoad.onNext(())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.remakeTableConstraints()
    }
    
    // MARK: Setup
    override func setupInputs() {
        mainView.tableView.rx.modelDeleted(FavoriteMovieViewModel.self).bind(to: viewModel.inputs.itemDeleted).disposed(by: disposeBag)
        mainView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    override func setupOutputs() {
        let identifier = String(describing: FavoriteMovieCell.self)
        mainView.tableView.register(FavoriteMovieCell.self, forCellReuseIdentifier: identifier)
        moviesDataSource.configureCell = { _, tableView, indexPath, itemViewModel in
            let cell = (tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavoriteMovieCell)!
            cell.viewModel = itemViewModel
            return cell

        }
        
        viewModel.outputs.tableItems
            .drive(mainView.tableView.rx.items(dataSource: moviesDataSource))
        .disposed(by: disposeBag)
                
    }
}

extension FavoriteListViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Deletar") { [weak self] (_, indexPath) in
            self?.mainView.tableView.dataSource?.tableView!((self?.mainView.tableView)!, commit: .delete, forRowAt: indexPath)
            return
        }

        return [deleteButton]
    }
}
