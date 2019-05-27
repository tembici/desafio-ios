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
    
    //private
    private var connectionManager : ConnectionManager = ConnectionManager.init()
    
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
    
    func updatePoster(fromURL : String){
        
        if (connectionManager.currentTask != nil){
            connectionManager.currentTask?.cancel()
        }
        
        if let img : UIImage = App.Delegate.imageCache.object(forKey: fromURL as AnyObject) as? UIImage {
            self.imvPoster.image = img
        }else{
            self.actIndicator.startAnimating()
            //
            connectionManager.getPoster(posterPath: fromURL) { (image, code, error) in
                DispatchQueue.main.async {
                    if let img = image {
                        App.Delegate.imageCache.setObject(img, forKey: self.connectionManager.currentTask?.currentRequest?.url?.absoluteString as AnyObject)
                        self.imvPoster.image = img
                        self.actIndicator.stopAnimating()
                    }
                }
            }
        }
        
    }
    
}
