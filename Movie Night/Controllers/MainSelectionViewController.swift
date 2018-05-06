//
//  ViewController.swift
//  Movie Night
//
//  Created by Jaakko Kenttä on 05/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import UIKit
import TMDBSwift

class MainSelectionViewController: UIViewController {
    
    var watcher1: WatcherDataModel?
    var watcher2: WatcherDataModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        TMDBConfig.apikey = "307c8c4a6807b3e4eac488ba365d7f08"
        
        // If there is no watchers. Setup them
        if watcher1 == nil {
            watcher1 = WatcherDataModel()
            watcher2 = WatcherDataModel()
        }
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
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        for actor in watcher1!.likedActors {
//            print(actor.name)
//        }
        navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "actorSelect" {
            let controller = segue.destination as! ActorSelectionViewController
            
            let sender = sender as! UIButton
            switch sender.tag {
            case 0:
                controller.actorsData = watcher1
            case 1:
                controller.actorsData = watcher2
            default:
                return
            }
        }
    }
    
    @IBAction func watcherSelection(_ sender: UIButton) {
            performSegue(withIdentifier: "actorSelect", sender: sender)
    }

}

