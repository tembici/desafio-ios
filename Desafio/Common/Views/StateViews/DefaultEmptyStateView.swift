import UIKit
import RxSwift
import RxGesture

class DefaultEmptyStateView: UIView {
    
    private var stackView = UIStackView()
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    
    private var disposeBag = DisposeBag()
    
    var retry = PublishSubject<Void>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    convenience init(title: String, subtitle: String) {
        self.init(frame: CGRect.zero)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        setup()
    }
    
    private func setup() {
        self.rx
            .tapGesture()
            .when(.recognized)
            .map({ _ in Void() })
            .bind(to: retry)
            .disposed(by: disposeBag)

        backgroundColor = .white
        
        addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 5
        
        addSubview(stackView)
        
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        stackView.addArrangedSubview(titleLabel)
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .center
        stackView.addArrangedSubview(subtitleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(40)
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(snp.right).offset(-20)
        }
    }
    
}
