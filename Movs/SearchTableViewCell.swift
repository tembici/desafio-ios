//
//  SearchTableViewCell.swift
//  BuscaFilmes
//
//  Created by Elias Amigo on 11/03/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
//
    @IBOutlet var poster: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var itemDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
