//
//  Movie.swift
//  Flicks
//
//  Created by Kaushik on 9/14/17.
//  Copyright © 2017 Dev. All rights reserved.
//

import UIKit
import SwiftyJSON

class FMMovie: NSObject {
    var origTitle:String?
    var overView:String?
    var title:String?
    var releaseDate:String?
    var posterPath = ""
    var backdropPath = ""
    var voteAvg:String?
    override init() {
        
    }
    init(withMovieDictionary dictionary : NSDictionary ) {
        
        let json            = JSON(dictionary)
        self.origTitle      = json[Constants.original_title].stringValue
        self.overView       = json[Constants.overview].stringValue
        self.title          = json[Constants.title].stringValue
        self.releaseDate    = json[Constants.release_date].stringValue
        self.posterPath     = json[Constants.poster_path].stringValue
        self.backdropPath   = json[Constants.backdrop_path].stringValue
        self.voteAvg        = json[Constants.vote_avg].stringValue

    }
}
