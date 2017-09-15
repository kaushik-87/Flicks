//
//  Movie.swift
//  Flicks
//
//  Created by Kaushik on 9/14/17.
//  Copyright © 2017 Dev. All rights reserved.
//

import UIKit

class FMMovie: NSObject {
    var origTitle = ""
    var overView = ""
    var title = ""
    var releaseDate = ""
    var posterPath = ""
    var backdropPath = ""
    init(withMovieDictionary dictionary : NSDictionary ) {
        if let originalTitle = dictionary[Constants.original_title] as? String {
            self.origTitle = originalTitle
        }
        
        if let overView = dictionary[Constants.overview] as? String {
            self.overView = overView
        }
        if let title = dictionary[Constants.title] as? String {
            self.title = title
        }
        if let releaseDate = dictionary[Constants.release_date] as? String {
            self.releaseDate = releaseDate
        }
        if let posterPath = dictionary[Constants.poster_path] as? String {
            self.posterPath = posterPath
        }
        if let backdropPath = dictionary[Constants.backdrop_path] as? String {
            self.backdropPath = backdropPath
        }
    }
}
