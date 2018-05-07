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
    var sizeParam = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        tableView.allowsSelection = false
        activeWatcher?.canViewResults = true
        
        let next = UIBarButtonItem(title: "Genre Selection >", style: .done, target:self, action: #selector(nextController))
        navigationItem.setRightBarButton(next, animated: true)
        

        ConfigurationMDB.configuration { clientData, configs in
            if let configData = configs {
                //self.baseURL = configData.base_url
                //print(self.baseURL)
                self.sizeParam = configData.still_sizes[0]
            }
        }
        if activeWatcher?.actorsList.count == 0 {
            PersonMDB.popular(page: 1) { data, ppl in
                if let people = ppl {
                    for human in people {
                        self.activeWatcher!.actorsList.append(human)
                        //print(human.name)
                        //print(human.profile_path)
                    }
                }
                self.tableView.reloadData()
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func nextController() {
        print("To the Genre selection.")
        performSegue(withIdentifier: "genreSelection", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "genreSelection" {
            let controller = segue.destination as? GenreSelectionViewController
            controller?.activeWatcher = activeWatcher
            controller?.watchers = watchers
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowNumber = activeWatcher?.actorsList.count {
            return rowNumber
        } else {
            return 0
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath) as! ActorTableViewCell
        
        let actor = activeWatcher!.actorsList[indexPath.row]
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
















