//
//  MovieCell.swift
//  IMDBInfo
//
//  Created by Adriaan Brands on 20-09-15.
//  Copyright © 2015 Adriaan Brands. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var movieImg : UIImageView!
    @IBOutlet weak var movieLbl : UILabel!
    
    func initCell(movie: Movie){
        
        if let title = movie.Title {
            
            movieLbl.text = title
            
        }
        
        if let path = movie.posterPath {
            
            let url = NSURL(string: path)!
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                
                let data = NSData(contentsOfURL : url)!
                

                dispatch_async(dispatch_get_main_queue()){
                    
                    let img = UIImage(data: data)
                    self.movieImg.image = img 
                    
                }
                
            }
            
        }
        
    }
}
