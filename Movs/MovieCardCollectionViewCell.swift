//
//  MovieCardCollectionViewCell.swift
//  Movs
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import UIKit

class MovieCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieScore: UIView!
    @IBOutlet weak var movieScoreValue: UILabel!
    @IBOutlet weak var movieVote: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setVote(_ vote: String) {
        movieVote?.text = vote
    }
    
    func setMovieScore(_ score: Float) {

        // animate progress
        // Do any additional setup after loading the view, typically from a nib.
        let circularProgress = CircularProgressView(frame: CGRect(x: 10.0, y: 30.0, width: ((movieScore?.frame.width)! * 0.8), height: ((movieScore?.frame.height)!  * 0.8)))
        circularProgress.center = (movieScore?.center)!
        circularProgress.setProgress(score / 10)
//        circularProgress.setProgressWithAnimation(duration: 1.0, value: (score / 10))
        movieScore?.addSubview(circularProgress)
        
        setMovieScoreValue(score)
    }
    
    func setMoviePoster(_ url: String?) {
        
        let repository = "https://image.tmdb.org/t/p/w154/"
        let address = URL(string: "\(repository)\(url!)")
        let data = try? Data(contentsOf: address!)
        
        if let imageData = data {
            moviePoster?.image = UIImage(data: imageData)
        }
    }
    
    func setMovieScoreValue(_ value: Float) {
        movieScoreValue?.text = String(value)
    }
}
