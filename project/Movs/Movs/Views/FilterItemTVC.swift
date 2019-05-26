//
//  FilterItemTVC.swift
//  Movs
//
//  Created by lordesire on 24/05/2019.
//  Copyright © 2019 EricoGT. All rights reserved.
//

import UIKit

class FilterItemTVC : UITableViewCell {

    //properties
    @IBOutlet var imvArrow : UIImageView!
    @IBOutlet var lblFilterName : UILabel!
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
        
        imvArrow.backgroundColor = UIColor.clear
        imvArrow.image = UIImage.init(named: "IconArrowRight")?.withRenderingMode(.alwaysTemplate)
        imvArrow.tintColor = App.Style.color2
        
        lblFilterName.backgroundColor = UIColor.clear
        lblFilterName.textColor = App.Style.color2
        lblFilterName.text = ""
        
        lblFilterValue.backgroundColor = UIColor.clear
        lblFilterValue.textColor = App.Style.color3
        lblFilterValue.text = ""
        
        
    }
    
}
