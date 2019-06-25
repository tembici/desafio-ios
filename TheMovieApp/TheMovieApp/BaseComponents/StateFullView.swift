//
//  StateFullView.swift
//  CaixaUI
//
//  Created by Wilson Kim on 09/05/19.
//

import UIKit

public enum ViewStateEnum {
    case loading(_ loadingMessage:String?)
    case error(_ errorMessage:String?)
    case empty(_ emptyMessage:String?, image:UIImage?)
    case normalLayout
}

public class StateFullView: UIView {
    
    var errorView = ErrorView()
    var loadingView = LoadingView()
    var emptyView = EmptyView()
    
    private var state:ViewStateEnum = .normalLayout {
        didSet {
            updateViewState()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setup()
    }
    
    private func setup() {
        setupErrorView()
        setupLoadingView()
        setupEmptyView()
    }
    
    private func setupErrorView() {
        addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        errorView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        errorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        errorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        errorView.isHidden = true
    }
    
    private func setupLoadingView() {
        addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        loadingView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        loadingView.isHidden = true
    }
    
    private func setupEmptyView() {
        addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        emptyView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        emptyView.isHidden = true
    }
    
    private func updateViewState() {
        switch state {
        case let .error(message):
            errorView.setErrorMessage(message)
            loadingView.stopLoading()
            errorView.isHidden = false
            loadingView.isHidden = true
            emptyView.isHidden = true
            break
        case let .loading(message):
            loadingView.setLoadingMessage(message)
            loadingView.startLoading()
            loadingView.isHidden = false
            errorView.isHidden = true
            emptyView.isHidden = true
            break
        case let .empty(message, image):
            emptyView.setImage(image)
            emptyView.setEmptyMessage(message)
            loadingView.stopLoading()
            errorView.isHidden = true
            loadingView.isHidden = true
            emptyView.isHidden = false
            break
        case .normalLayout:
            loadingView.stopLoading()
            errorView.isHidden = true
            loadingView.isHidden = true
            emptyView.isHidden = true
            break
        }
    }
    
    public func setState(_ state:ViewStateEnum) {
        self.state = state
    }
    
    public func setErrorCompletion(_ errorBlock:@escaping () -> Void) {
        errorView.setCompletion {
            errorBlock()
        }
    }
}
