//
//  GenreTableViewCell.swift
//  Movie Night
//
//  Created by Jaakko Kenttä on 07/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import UIKit
import TMDBSwift

protocol GenreTableViewCellDelegate {
    func favoriteGenre(with genre: GenresMDB)
    func deFavoriteGenre(with genre: GenresMDB)
}

class GenreTableViewCell: UITableViewCell {

    
    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
    
    var isGenreSelected = false
    
    var delegate: GenreTableViewCellDelegate?
    var currentGenre: GenresMDB?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        print("cell init")
        self.selectionStyle = .none
        self.contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let font = UIFont(name: "Helvetica", size: 20)
        self.genreNameLabel.font = font
        genreNameLabel.textColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        
        selectionButton.setTitle("😶", for: .normal)
        selectionButton.setTitle("😍", for: .selected)
        selectionButton.titleLabel?.font = UIFont(name: "Helvetica", size: 50)
        selectionButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        
    }
    
    @IBAction func genreSelection(_ sender: Any) {
        
        if isGenreSelected {
            if let currentGenre = currentGenre {
                delegate?.deFavoriteGenre(with: currentGenre)
            }
        } else {
            if let currentGenre = currentGenre {
                delegate?.favoriteGenre(with: currentGenre)
            }
        }
        
        isGenreSelected = !isGenreSelected
        selectionButton.isSelected = isGenreSelected
    }
    
    override func prepareForReuse() {
        isGenreSelected = false
        selectionButton.isSelected = false
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
