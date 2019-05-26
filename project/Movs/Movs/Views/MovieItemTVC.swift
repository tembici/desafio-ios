//
//  MovieItemTVC.swift
//  Movs
//
//  Created by lordesire on 25/05/2019.
//  Copyright © 2019 EricoGT. All rights reserved.
//

import UIKit

class MovieItemTVC : UITableViewCell {
    
    //properties
    @IBOutlet var imvFavorite : UIImageView!
    @IBOutlet var lblItem : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setupLayout() {
        
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        //
        self.layoutIfNeeded()
        
        imvFavorite.backgroundColor = UIColor.clear
        imvFavorite.image = UIImage.init(named: "IconFavoriteGray")
        imvFavorite.isHidden = true
        
        lblItem.backgroundColor = UIColor.clear
        lblItem.textColor = App.Style.color2
        lblItem.text = ""
        
    }
    
}
