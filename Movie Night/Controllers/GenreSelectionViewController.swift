//
//  GenreSelectionViewController.swift
//  Movie Night
//
//  Created by Jaakko Kenttä on 06/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import UIKit
import TMDBSwift

class GenreSelectionViewController: UITableViewController {
    
    var activeWatcher: WatcherDataModel?
    var watchers: Watchers?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let watchers = watchers else {
            fatalError()
        }

        // Create Done Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toTheMainMenu))
        navigationItem.setRightBarButton(doneBtn, animated: true)
        
        
        // Get the genres if not got
        if watchers.genresList.count == 0 {
            GenresMDB.genres(listType: .movie, language: "en"){
                apiReturn, genres in
                if let genres = genres{
                    genres.forEach{
                        self.watchers?.genresList.append($0)
                    }
                }
                self.tableView.reloadData()
            }
        }
        
    }

    @objc func toTheMainMenu() {
        performSegue(withIdentifier: "mainMenuSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainMenuSegue" {
            let controller = segue.destination as! MainSelectionViewController
            controller.watchers = watchers
        }
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let watcherCount = watchers?.genresList.count {
            return watcherCount
            
        } else {
            return 0
        }
        
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath) as! GenreTableViewCell

        let genre = watchers?.genresList[indexPath.row]
        cell.genreNameLabel.text = genre?.name
        cell.currentGenre = genre
        cell.delegate = activeWatcher
        

        for genre1 in activeWatcher!.likedGenres {
            if genre1 == genre {
                cell.isGenreSelected = true
                cell.selectionButton.isSelected = true
            }
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
