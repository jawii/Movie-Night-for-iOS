//
//  ViewController.swift
//  Movie Night
//
//  Created by Jaakko Kenttä on 05/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import UIKit
import TMDBSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        TMDBConfig.apikey = "307c8c4a6807b3e4eac488ba365d7f08"
        
//            MovieMDB.movie(movieID: 7984, language: "en") { apiReturn, movie  in
//                print(movie?.title);
//            }
//            GenresMDB.genres(listType: .movie, language: "en") { apiReturn, genres in
//
//                if let genres = genres {
//                    for genre in genres {
//                        print(genre.name)
//                    }
//                }
//            }
            PersonMDB.popular(page: 1) { data, ppl in
                if let people = ppl {
                    for human in people {
                        print(human.name)
                    }
                }
            }
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

