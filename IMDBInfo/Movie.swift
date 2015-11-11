//
//  Movie.swift
//  IMDBInfo
//
//  Created by Adriaan Brands on 20-09-15.
//  Copyright © 2015 Adriaan Brands. All rights reserved.
//

import Foundation

class Movie {
    
    let URL_BASE = "http://image.tmdb.org/t/p/w500"
    
    var Title : String!
    var Overview : String!
    var posterPath : String!
    var backdropPath : String!
    var voteAvg : String!
    var releaseDate : String!
    
    
    init(movieDict: Dictionary<String,AnyObject>){
        
        if let Title = movieDict["title"] as? String{
            self.Title = Title
        }
        
        if let Overview = movieDict["overview"] as? String {
            self.Overview = Overview
        }
        
        if let path = movieDict["poster_path"] as? String {
            
            self.posterPath = "\(URL_BASE)\(path)"
        }
        
        if let backpath = movieDict["backdrop_path"] as? String {
            
            self.backdropPath = "\(URL_BASE)\(backpath)"
            
        }
        
        if let vote = movieDict["vote_average"] as? Float {
            
            self.voteAvg = "\(vote)"
        }
        
        if let rDate = movieDict["release_date"] as? String {
            
            self.releaseDate = rDate
            
        }

    }

}