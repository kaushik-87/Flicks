//
//  MoviesManager.swift
//  Flicks
//
//  Created by Kaushik on 9/13/17.
//  Copyright © 2017 Dev. All rights reserved.
//

import UIKit

struct Movie {
    var name : String
//    var thumbnailUrl : String
//    var posterUrl : String
    var description : String
    
}
class MoviesManager: NSObject {
    static let sharedManager : MoviesManager = {
        let instance = MoviesManager()
        return instance
    }()

    func fetchNowPlayingMovies() -> [Movie] {
        var moviesList = NSMutableArray.init()
        let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=39c77c9745fd06851e28fcf94062eeb2")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        if let moviesInDictionary = responseDictionary["results"] as? [NSDictionary]
                        {
                            for movieDictionary in moviesInDictionary {
                                let movie = Movie(name: (movieDictionary["original_title"] as? String)!,description: (movieDictionary["overview"] as? String)!)
                                moviesList.add(movie)
                            }
                        }
                        else
                        {
                            
                        }
                        print("responseDictionary: \(moviesList)")
                    }
                }
        });
        task.resume()
        
        return moviesList as! [Movie]
    }
    
}
