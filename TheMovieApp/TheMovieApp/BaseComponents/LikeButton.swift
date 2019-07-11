//
//  LikeButton.swift
//  TheMovieApp
//

import UIKit

class FavoriteButton: UIButton {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func commonInit() {
        setBackgroundImage(UIImage(named: "icon_selected_favorite"), for: .selected)
        setBackgroundImage(UIImage(named: "icon_unselected_favorite"), for: .normal)
        tintColor = UIColor.clear
    }
}
