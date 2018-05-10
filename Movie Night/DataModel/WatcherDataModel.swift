//
//  WatcherDataModel.swift
//  Movie Night
//
//  Created by Jaakko Kenttä on 06/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import Foundation
import TMDBSwift

class WatcherDataModel {
    
    var canViewResults = false
    var likedActors: [PersonResults] = [] {
        didSet {
            print("Persons in liked list:")
            for actor in likedActors {
                print(actor.name!)
            }
            print("\n")
        }
    }
    var disLikedActors: [PersonResults] = [] {
        didSet {
            print("Persons in disliked list:")
            for actor in disLikedActors {
                print(actor.name!)
            }
            print("\n")
        }
    }
    
    var likedGenres: [GenresMDB] = [] {
        didSet {
            print("Liked Genres:")
            for genre in likedGenres {
                if let genreName = genre.name {
                    print("\(genreName) \n")
                } else {
                   print("\(genre) \n")
                }
                
            }
        }
    }
}

extension WatcherDataModel: ActorTableViewCellDelegate {
    func removeFromLikedList(person: PersonResults) {
        let index = likedActors.index(of: person)
        likedActors.remove(at: index!)
    }
    
    func removeFromDisLikedList(person: PersonResults) {
        let index = disLikedActors.index(of: person)
        disLikedActors.remove(at: index!)
    }
    
    func addToLikedList(person: PersonResults) {
        likedActors.append(person)
    }
    
    func addTodisLikedList(person: PersonResults) {
        disLikedActors.append(person)
    }
}

extension WatcherDataModel: GenreTableViewCellDelegate {
    func favoriteGenre(with genre: GenresMDB) {
        likedGenres.append(genre)
    }
    func deFavoriteGenre(with genre: GenresMDB) {
        
        let index = likedGenres.index(of: genre)
        if let index = index {
            likedGenres.remove(at: index)
        }
    }
}








