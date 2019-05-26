//
//  FilterValueTVC.swift
//  Movs
//
//  Created by lordesire on 24/05/2019.
//  Copyright © 2019 EricoGT. All rights reserved.
//

import UIKit

class FilterValueTVC : UITableViewCell {
    
    //properties
    @IBOutlet var imvCheck : UIImageView!
    @IBOutlet var lblFilterValue : UILabel!
    
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
        
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        //
        self.layoutIfNeeded()
        
        imvCheck.backgroundColor = UIColor.clear
        imvCheck.image = UIImage.init(named: "IconCheck")?.withRenderingMode(.alwaysTemplate)
        imvCheck.tintColor = App.Style.color3
        imvCheck.isHidden = true
                
        lblFilterValue.backgroundColor = UIColor.clear
        lblFilterValue.textColor = App.Style.color2
        lblFilterValue.text = ""
        
        
    }
    
}
