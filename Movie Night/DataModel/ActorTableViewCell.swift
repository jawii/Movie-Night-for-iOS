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

enum actorLikeValues: String {
    case disLike = "☹️"
    case like = "😍"
    case neutral = "😶"
}


class ActorTableViewCell: UITableViewCell{
    
    private let buttonBGcolor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    
    var person: PersonResults?
    var delegate: ActorTableViewCellDelegate?

    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    
    var liked: Bool = false
    var disLiked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        actorName.textColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func configureButtons() {
        if !liked && !disLiked {
            likeButton.setTitle("😶", for: .normal)
        } else if liked {
            likeButton.setTitle("😍", for: .normal)
        } else if disLiked {
            likeButton.setTitle("☹️", for: .normal)
        }
        
    }
    
    @IBAction func actorLiked(_ sender: UIButton) {
        
        guard let person = person else { print("No person"); return }
        
        if !liked && !disLiked {
            liked = true
            delegate?.addToLikedList(person: person)
        } else if liked {
            delegate?.removeFromLikedList(person: person)
            delegate?.addTodisLikedList(person: person)
            liked = false
            disLiked = true
        } else if disLiked {
            delegate?.removeFromDisLikedList(person: person)
            delegate?.addTodisLikedList(person: person)
            liked = false
            disLiked = false
        }
        
        //delegate?.addToLikedList(person: person)
        //delegate?.removeFromDisLikedList(person: person!)
        configureButtons()
    }
    
    //delegate?.addToLikedList(person: person)
    //delegate?.removeFromDisLikedList(person: person!)
    
}










