//
//  Watchers.swift
//  Movie Night
//
//  Created by Jaakko Kenttä on 07/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import Foundation
import TMDBSwift

class Watchers {
    var watcher1 = WatcherDataModel()
    var watcher2 = WatcherDataModel()
    
    var genresList: [GenresMDB] = []
    var actorsList: [PersonResults] = []
    
    lazy var listOfAllMovies: [KnownForMovie] = {
        
        var list: Set<KnownForMovie> = []
        for actor in actorsList {
            for movie in actor.known_for.movies! {
                list.insert(movie)
            }
        }
        print(list.count)
        let returnList = Array(list)
        print(returnList.count)
        return returnList
    }()
}
