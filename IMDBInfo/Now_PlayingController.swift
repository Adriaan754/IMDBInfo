//
//  Now_PlayinController.swift
//  IMDBInfo
//
//  Created by Adriaan Brands on 19-09-15.
//  Copyright © 2015 Adriaan Brands. All rights reserved.
//

import UIKit

class Now_PlayingController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    let URL_BASE = "http://api.themoviedb.org/3/movie/now_playing?api_key=0bc401d279fd392d8248f28581e9fd02"
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    var movies = [Movie]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        downloadData()
        
    }
    func downloadData(){
        
        let url = NSURL(string: URL_BASE)!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) ->
            Void in
            
            if error != nil{
                print(error.debugDescription)
            }else{
                do{
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        as? Dictionary<String,AnyObject>
                    if let results = dict!["results"] as? [Dictionary<String,AnyObject>]{
                        
                        print(results)
                        
                        for obj in results{
                            let movie = Movie(movieDict:obj)
                            self.movies.append(movie)
                        }
                        //Reload Main UI Thread
                        dispatch_async(dispatch_get_main_queue()){
                            self.collectionView.reloadData()
                        }
                    }
                }
                catch{
                    
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell",
            forIndexPath: indexPath) as? MovieCell{
                
                let movie = movies[indexPath.row]
                cell.initCell(movie)
                return cell
        }else{
            return MovieCell()
        }
        
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(360, 460)
        
    }
}

