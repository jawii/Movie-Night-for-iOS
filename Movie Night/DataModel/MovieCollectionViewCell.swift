//
//  MovieCollectionViewCell.swift
//  Movie Night
//
//  Created by Jaakko Kenttä on 07/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var recomNumber: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

}
