import Foundation
import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: StatefulView {
    var state: Binder<ViewState> {
        return Binder(self.base) { control, value in
            control.setState(state: value)
        }
    }
}

public enum ViewState: String, CaseIterable {
    case loading
    case error
    case empty
    case custom
    case none
}

open class StatefulView: UIView {
    
    // Default Views
    private var state: ViewState = ViewState.loading
    private var viewDictionary: [ViewState: String] = [:]
    private var views: [ViewState: UIView] = [:]
    private var completionBlocks: [ViewState: CompletionHandler] = [:]
    public typealias CompletionHandler = () -> Void
    public typealias ClickHandler = (UITapGestureRecognizer) -> Void
    
    // Set Views By Direct Reference
    public func setAvailableViews(loadingView: UIView? = nil, errorView: UIView? = nil, emptyView: UIView? = nil, customView: UIView? = nil) {
        // Loading
        if let loading = loadingView {
            views[ViewState.loading] = loading
        }
        // Error
        if let error = errorView {
            views[ViewState.error] = error
        }
        // Empty
        if let empty = emptyView {
            views[ViewState.empty] = empty
        }
        // Custom
        if let custom = customView {
            views[ViewState.custom] = custom
        }
    }
    
    // Set Views By Dictionary
    public func setAvailableViewsByName(loadingView: String? = nil, errorView: String? = nil, emptyView: String? = nil, customView: String? = nil) {
        // Loading
        if let loading = loadingView {
            viewDictionary[ViewState.loading] = loading
        }
        // Error
        if let error = errorView {
            viewDictionary[ViewState.error] = error
        }
        // Empty
        if let empty = emptyView {
            viewDictionary[ViewState.empty] = empty
        }
        // Custom
        if let custom = customView {
            viewDictionary[ViewState.custom] = custom
        }
    }
    // Set Current State
    public func setState(state: ViewState) {
        self.state = state
        self.reloadView()
    }
    // Remove Current View
    private func removeCurrentView() {
        views.forEach { $0.value.removeFromSuperview() }
    }
    
    // Reload View
    private func reloadView() {
        self.removeCurrentView()
        if state == .none { return }
        self.setSelectedView()
    }
    // Load View from NIB
    private func instanceFromNib(name: String, useDefault: Bool = false) -> UIView? {
        if let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView {
            return view
        }
        return nil
    }
    // Select View And Redraw
    private func setSelectedView() {
        self.removeCurrentView()
        var stateView: UIView?
        if let viewByRef = views[self.state] {
            stateView = viewByRef
        } else if let stateViewByName = viewDictionary[self.state] {
            if let view = self.instanceFromNib(name: stateViewByName) {
                stateView = view
            }
        }
        if completionBlocks[self.state] != nil {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
            stateView!.addGestureRecognizer(tapGesture)
        }
        
        if let stateView = stateView, let lastSubView = subviews.last {
            self.insertSubview(stateView, aboveSubview: lastSubView)
            stateView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        if let block = completionBlocks[self.state] {
            block()
        }
    }
    
    // Handle Simple Action Events of Views
    public func setHandlers(errorView: CompletionHandler? = nil, emptyView: CompletionHandler? = nil, customView: CompletionHandler? = nil) {
        // Error
        if let error = errorView {
            completionBlocks[ViewState.error] = error
        }
        // Empty
        if let empty = emptyView {
            completionBlocks[ViewState.empty] = empty
        }
        // Custom
        if let custom = customView {
            completionBlocks[ViewState.custom] = custom
        }
    }
}
