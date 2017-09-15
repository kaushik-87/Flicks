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
    var origTitle = ""
    var overView = ""
    var title = ""
    var releaseDate = ""
    var posterPath = ""
    var backdropPath = ""
    init(withMovieDictionary dictionary : NSDictionary ) {
        
        let json = JSON(dictionary)
        self.origTitle = json[Constants.original_title].stringValue
        self.overView  = json[Constants.overview].stringValue
        self.title     = json[Constants.title].stringValue
        self.releaseDate     = json[Constants.release_date].stringValue
        self.posterPath     = json[Constants.poster_path].stringValue
        self.backdropPath     = json[Constants.backdrop_path].stringValue


//        if let originalTitle = dictionary[Constants.original_title] as? String {
//            self.origTitle = originalTitle
//        }
        
//        if let overView = dictionary[Constants.overview] as? String {
//            self.overView = overView
//        }
//        if let title = dictionary[Constants.title] as? String {
//            self.title = title
//        }
//        if let releaseDate = dictionary[Constants.release_date] as? String {
//            self.releaseDate = releaseDate
//        }
//        if let posterPath = dictionary[Constants.poster_path] as? String {
//            self.posterPath = posterPath
//        }
//        if let backdropPath = dictionary[Constants.backdrop_path] as? String {
//            self.backdropPath = backdropPath
//        }
    }
}
