//
//  FavoriteTVC.swift
//  Movs
//
//  Created by lordesire on 24/05/2019.
//  Copyright © 2019 EricoGT. All rights reserved.
//

import UIKit

class FavoriteTVC : UITableViewCell {
    
    //properties
    @IBOutlet var imvPoster : UIImageView!
    @IBOutlet var lblMovieTitle : UILabel!
    @IBOutlet var lblMovieYear : UILabel!
    @IBOutlet var lblMovieDescription : UILabel!
    @IBOutlet var actIndicator : UIActivityIndicatorView!
    
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
        
        self.backgroundColor = UIColor.groupTableViewBackground
        self.contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        //
        self.layoutIfNeeded()
        
        imvPoster.backgroundColor = App.Style.color1
        imvPoster.image = nil
        
        lblMovieTitle.backgroundColor = UIColor.clear
        lblMovieTitle.textColor = App.Style.color2
        lblMovieTitle.text = ""
        
        lblMovieYear.backgroundColor = UIColor.clear
        lblMovieYear.textColor = App.Style.color2
        lblMovieYear.text = ""
        
        lblMovieDescription.backgroundColor = UIColor.clear
        lblMovieDescription.textColor = App.Style.color2
        lblMovieDescription.text = ""
        
        actIndicator.color = App.Style.color2
        actIndicator.stopAnimating()
        
    }
    
}
