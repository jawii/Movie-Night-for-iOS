//
//  ActorSelectionViewController.swift
//  Movie Night
//
//  Created by Jaakko Kenttä on 05/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import UIKit
import TMDBSwift

class ActorSelectionViewController: UITableViewController {
    
    
    var activeWatcher: WatcherDataModel?
    var watchers: Watchers?
    
    var baseURL = "https://image.tmdb.org/t/p/"
    var sizeParam = "w92"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let watchers = watchers else {
            print("No Watchers on ActorSelection")
            fatalError()
        }
        
        
        navigationController?.isNavigationBarHidden = false
        tableView.allowsSelection = false
        activeWatcher?.canViewResults = true
        
        let next = UIBarButtonItem(title: "Genres >", style: .done, target:self, action: #selector(nextController))
        navigationItem.setRightBarButton(next, animated: true)
        
//        ConfigurationMDB.configuration { clientData, configs in
//            if let configData = configs {
//                self.baseURL = configData.base_url
//                print(self.baseURL)
//                self.sizeParam = configData.still_sizes[0]
//                print(configData.still_sizes)
//            }
//        }
        if watchers.actorsList.count == 0 {
            
            for page in 1...2 {
                PersonMDB.popular(page: page) { data, ppl in
                    if let people = ppl {
                        for human in people {
                            self.watchers!.actorsList.append(human)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
            
        } else {
            self.tableView.reloadData()
        }
    }
    
    @objc func nextController() {
        performSegue(withIdentifier: "genreSelection", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "genreSelection" {
            let controller = segue.destination as? GenreSelectionViewController
            controller?.activeWatcher = activeWatcher
            controller?.watchers = watchers
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowNumber = watchers?.actorsList.count {
            return rowNumber
        } else {
            return 0
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath) as! ActorTableViewCell
        
        let actor = watchers!.actorsList[indexPath.row]
        cell.delegate = activeWatcher
        
        cell.person = actor
        cell.liked = false
        for actor1 in activeWatcher!.likedActors {
            if actor1 == actor {
                cell.liked = true
            }
        }
        cell.disLiked = false
        for actor1 in activeWatcher!.disLikedActors {
            if actor1 == actor {
                cell.disLiked = true
            }
        }
        cell.configureButtons()
        
        cell.actorName.text = actor.name
        let imageURL = baseURL + sizeParam
        
        if let imagePath = actor.profile_path {
            cell.actorImage.downloadedFrom(link: imageURL + imagePath)
        } else {
            cell.actorImage.image = #imageLiteral(resourceName: "placeHolderImage")
        }

        return cell
    }
}
















