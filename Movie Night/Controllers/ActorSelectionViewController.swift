//
//  ActorSelectionViewController.swift
//  Movie Night
//
//  Created by Jaakko Kenttä on 05/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import UIKit
import TMDBSwift

class ActorTableViewCell: UITableViewCell{
    
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorImage: UIImageView!
    
    @IBOutlet weak var yesButton: UIButton! {
        didSet {
            customizeBtn(for: yesButton)
        }
    }
    @IBOutlet weak var noButton: UIButton! {
        didSet {
            customizeBtn(for: noButton)
        }
    }
    
    var liked: Bool = false
    var disLiked: Bool = false
    
    private func customizeBtn(for button: UIButton) {
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.titleLabel?.font.withSize(42)
        button.titleLabel?.textColor = UIColor.blue
    }
    
    @IBAction func actorLiked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        liked = !liked
        print("Actor liked!")
    }
    @IBAction func actorDisLiked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    
    
    
}

class ActorSelectionViewController: UITableViewController {
    
    
    var actors: [PersonResults] = []
    var baseURL = "https://image.tmdb.org/t/p/"
    var sizeParam = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false

        ConfigurationMDB.configuration { clientData, configs in
            if let configData = configs {
                //self.baseURL = configData.base_url
                //print(self.baseURL)
                self.sizeParam = configData.still_sizes[0]
            }
        }
    

        PersonMDB.popular(page: 1) { data, ppl in
            if let people = ppl {
                for human in people {
                    self.actors.append(human)
                    //print(human.name)
                    //print(human.profile_path)
                }
            }
            self.tableView.reloadData()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(actors.count)
        return actors.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath) as! ActorTableViewCell
        
        cell.actorName.text = actors[indexPath.row].name
        let imageURL = baseURL + sizeParam
        
        if let imagePath = actors[indexPath.row].profile_path {
            cell.actorImage.downloadedFrom(link: imageURL + imagePath)
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
















