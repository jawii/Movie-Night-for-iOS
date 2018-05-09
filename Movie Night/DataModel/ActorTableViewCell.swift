//
//  ActorTableViewCell.swift
//  Movie Night
//
//  Created by Jaakko Kenttä on 06/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import Foundation
import TMDBSwift

protocol ActorTableViewCellDelegate {
    func addToLikedList(person:PersonResults)
    func addTodisLikedList(person:PersonResults)
    func removeFromLikedList(person: PersonResults)
    func removeFromDisLikedList(person: PersonResults)
}


class ActorTableViewCell: UITableViewCell{
    
    private let buttonBGcolor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    
    var person: PersonResults?
    var delegate: ActorTableViewCellDelegate?

    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorImage: UIImageView!
    
    @IBOutlet weak var yesButton: UIButton! {
        didSet {
            configureButtons()
        }
    }
    @IBOutlet weak var noButton: UIButton!
    
    var liked: Bool = false
    var disLiked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        actorName.textColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func configureButtons() {
        if !liked {
            yesButton.backgroundColor = buttonBGcolor
            yesButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        } else {
            yesButton.backgroundColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
            yesButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .selected)
        }
        if !disLiked {
            noButton.backgroundColor = buttonBGcolor
            noButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        } else {
            noButton.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            noButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .selected)
        }
        
    }
    
    @IBAction func actorLiked(_ sender: UIButton) {
        
        // If actor is disliked, unselect that
        if disLiked {
            // Remove actor from array
            delegate?.removeFromDisLikedList(person: person!)
            disLiked = false
        }
        if !liked {
            if let person = person {
                delegate?.addToLikedList(person: person)
            }
            
            
        }
        sender.isSelected = !sender.isSelected
        liked = !liked
        configureButtons()
    }
    @IBAction func actorDisLiked(_ sender: UIButton) {
        
        if liked {
            //remove actor from array
            liked = false
            delegate?.removeFromLikedList(person: person!)
            
        }
        if !disLiked {
            if let person = person {
                delegate?.addTodisLikedList(person: person)
            }
        }
        
        sender.isSelected = !sender.isSelected
        disLiked = !disLiked
        configureButtons()
    }
    
}
