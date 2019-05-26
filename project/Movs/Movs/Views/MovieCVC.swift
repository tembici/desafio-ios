//
//  MovieCVC.swift
//  Movs
//
//  Created by lordesire on 24/05/2019.
//  Copyright © 2019 EricoGT. All rights reserved.
//

import UIKit

class MovieCVC : UICollectionViewCell {
    
    //properties:
    @IBOutlet var bottomView : UIView!
    @IBOutlet var imvFavorite : UIImageView!
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var imvPoster : UIImageView!
    @IBOutlet var actIndicator : UIActivityIndicatorView!
    //
    var favoriteImage : UIImage = UIImage.init(named: "IconFavoriteFull")!.withRenderingMode(.alwaysTemplate)
    
    //private:
    private var connectionManager : ConnectionManager = ConnectionManager.init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupLayout(favorite : Bool) {
        
        self.layoutIfNeeded()
        
        self.backgroundColor = UIColor.white
        
        bottomView.backgroundColor = App.Style.color2
        
        lblTitle.textColor = App.Style.color1
        lblTitle.text = ""
        
        imvPoster.backgroundColor = App.Style.color1
        imvPoster.image = nil
        
        imvFavorite.backgroundColor = UIColor.clear
        imvFavorite.image = favoriteImage
        
        if (favorite) {
            imvFavorite.tintColor = App.Style.color1
        }else{
            imvFavorite.tintColor = App.Style.color4
        }
        
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
