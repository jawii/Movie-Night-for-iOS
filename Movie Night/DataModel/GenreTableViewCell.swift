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
        self.contentView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        let font = UIFont(name: "Helvetica", size: 24)
        self.genreNameLabel.font = font
        
        selectionButton.setTitle("🌚", for: .normal)
        selectionButton.setTitle("👌🏽", for: .selected)
        selectionButton.titleLabel?.font = UIFont(name: "Helvetica", size: 40)
        selectionButton.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)

        
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
