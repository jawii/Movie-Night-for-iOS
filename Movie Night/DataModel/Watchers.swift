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
        
        // Create set at start to remove duplicates
        var list: Set<KnownForMovie> = []
        for actor in actorsList {
            for movie in actor.known_for.movies! {
                list.insert(movie)
            }
        }
        let returnList = Array(list)
        return returnList
    }()
    
    lazy var moviePoints: [(movie: KnownForMovie, score: Int)] = {
        
        var list: [(movie: KnownForMovie, score: Int)] = []
       
        //Go trough movies
        for movie in listOfAllMovies {
            var score = 0
            
            //Go trough liked actors and disliked actors
            for actor in watcher1.likedActors {
                for actorMovie in actor.known_for.movies! {
                    if actorMovie == movie {
                        score += 1
                    }
                }
            }
            for actor in watcher1.disLikedActors {
                for actorMovie in actor.known_for.movies! {
                    if actorMovie == movie {
                        score -= 1
                    }
                }
            }
            for actor in watcher2.likedActors {
                for actorMovie in actor.known_for.movies! {
                    if actorMovie == movie {
                        score += 1
                    }
                }
            }
            for actor in watcher2.disLikedActors {
                for actorMovie in actor.known_for.movies! {
                    if actorMovie == movie {
                        score -= 1
                    }
                }
            }
            // Go trough genres
            for genre in watcher1.likedGenres {
                for genreID in movie.genre_ids! {
                    if genre.id == genreID {
                        score += 1
                    }
                }
            }
            
            
            list.append((movie: movie, score: score))
        }
        
        
        
        return list.sorted {$0.score > $1.score}
    }()
}
