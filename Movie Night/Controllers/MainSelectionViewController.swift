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
    
    var watchers: Watchers?
    
    @IBOutlet weak var watcherOneBtn: UIButton!
    @IBOutlet weak var watcherTwoBtn: UIButton!
    
    
    @IBOutlet weak var viewResults: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        TMDBConfig.apikey = "307c8c4a6807b3e4eac488ba365d7f08"
        
        // If there is no watchers. Setup them
        if watchers == nil {
            print("Wathcers were nil!")
            watchers = Watchers()
        }
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        
        let canViewResults1: Bool = watchers!.watcher1.canViewResults
        let canViewResults2: Bool = watchers!.watcher2.canViewResults
        
        
        viewResults.isHidden = !(canViewResults1 && canViewResults2)
        
        if watchers!.watcher1.canViewResults {
            watcherOneBtn.setImage(#imageLiteral(resourceName: "bubble-selected"), for: .normal)
        }
        if watchers!.watcher2.canViewResults {
            watcherTwoBtn.setImage(#imageLiteral(resourceName: "bubble-selected"), for: .normal)
        }
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "actorSelect" {
            let controller = segue.destination as! ActorSelectionViewController
            
            let sender = sender as! UIButton
            controller.watchers = watchers
            switch sender.tag {
            case 0:
                controller.activeWatcher = watchers?.watcher1
            case 1:
                controller.activeWatcher = watchers?.watcher2
            default:
                return
            }
        }
        if segue.identifier == "movieSelection" {
            let controller = segue.destination as! MovieSelectCollectionViewController
            controller.watchers = watchers
        }
    }
    
    @IBAction func watcherSelection(_ sender: UIButton) {
            performSegue(withIdentifier: "actorSelect", sender: sender)
    }
    
    @IBAction func movieSeletion(_ sender: Any) {
        performSegue(withIdentifier: "movieSelection", sender: nil)
    }

}

