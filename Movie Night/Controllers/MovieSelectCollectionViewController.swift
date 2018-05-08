//
//  MovieSelectCollectionViewController.swift
//  Movie Night
//
//  Created by Jaakko Kenttä on 07/05/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import UIKit
import TMDBSwift

private let reuseIdentifier = "movieCell"

class MovieSelectCollectionViewController: UICollectionViewController {
    
    var watchers: Watchers?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        // Create movies
        for _ in watchers!.listOfAllMovies {
//            print(movie.poster_path)
        }
        collectionView?.reloadData()
        
        
//        for movie in watchers!.moviePoints {
//            print(movie.movie.original_title)
//            print(movie.score)
//            for genreID in movie.movie.genre_ids! {
//                print(genreID)
//            }
//        }
//        MovieMDB.images(movieID: 871, language: "en"){
//            data, imgs in
//            if let images = imgs{
//                print(images.posters[0].file_path)
//                //Backdrop & stills might return `nil`
//                // print(images.stills[0].file_path)
//                //print(images.backdrops[0].file_path)
//            }
//        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return watchers!.moviePoints.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        let movie = watchers!.moviePoints[indexPath.row]
        // Configure the cell
        let baseURL = "https://image.tmdb.org/t/p/"
        let sizeParam = "w92"
        let filePath = movie.movie.poster_path
        
        if let filePath = filePath {
            cell.movieImage.downloadedFrom(link: baseURL + sizeParam + filePath)
        } else {
            cell.movieImage.image = #imageLiteral(resourceName: "placeHolderImage")
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
