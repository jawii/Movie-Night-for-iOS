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
        
        guard let watchers = watchers else {
            print("No watchers")
            fatalError()
        }
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barStyle = .black
        
        //calculate frame width
        let width = view.frame.size.width
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: width, height: width)
        
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

    
        watchers.moviePoints = watchers.createMovieResults()
        collectionView?.reloadData()
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
        let sizeParam = "w300"
        let filePath = movie.movie.poster_path
        
        if let filePath = filePath {
            cell.movieImage.downloadedFrom(link: baseURL + sizeParam + filePath)
        } else {
            cell.movieImage.image = #imageLiteral(resourceName: "placeHolderImage")
        }
        
        cell.movieTitle.text = movie.movie.original_title
//        print("Movie name and points: \(movie.movie.title): \(movie.score)")
        cell.recomNumber.text = "#\(indexPath.row + 1)"
        
        return cell
    }

}
