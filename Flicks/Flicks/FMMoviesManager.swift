//
//  MoviesManager.swift
//  Flicks
//
//  Created by Kaushik on 9/13/17.
//  Copyright © 2017 Dev. All rights reserved.
//

import UIKit

class FMMoviesManager: NSObject {
    static let sharedManager : FMMoviesManager = {
        let instance = FMMoviesManager()
        return instance
    }()

    //var imageURL:String
    func fetchConfigurations() -> Void {
        let url = URL(string:"https://api.themoviedb.org/3/configuration?api_key=39c77c9745fd06851e28fcf94062eeb2")
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
                        if let imagesDictionary = responseDictionary["images"] as? NSDictionary
                        {
                            if let baseURL = imagesDictionary["base_url"] as? String{
                                
                                //self.imageURL = baseURL
                            }
                        }
                        else
                        {
                            
                        }
                        print("responseDictionary: \(responseDictionary)")
                    }
                }
        });
        task.resume()
    }
    func fetchNowPlayingMovies(completionHandler :  @escaping (_ movies : [FMMovie]?, NSError?)->Void){
        let moviesList = NSMutableArray.init()
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
                                print(movieDictionary)
                                let mov = FMMovie.init(withMovieDictionary: movieDictionary)
                                moviesList.add(mov)
                            }
                            completionHandler(moviesList as? [FMMovie], nil)
                        }
                        else
                        {
                            let error = NSError(domain: "kFMMovieErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error fetching the details from the server"])
                            completionHandler(nil, error)

                        }
                        print("responseDictionary: \(moviesList)")
                    }
                }else{
                    let error = NSError(domain: "kFMMovieErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error fetching the details from the server"])
                    completionHandler(nil, error)
                }
        });
        task.resume()
    }
    
    func fetchTopRatedMovies(completionHandler :  @escaping (_ movies : [FMMovie]?, NSError?)->Void){
        let moviesList = NSMutableArray.init()
        let url = URL(string:"https://api.themoviedb.org/3/movie/top_rated?api_key=39c77c9745fd06851e28fcf94062eeb2")
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
                                print(movieDictionary)
                                let mov = FMMovie.init(withMovieDictionary: movieDictionary)
                                moviesList.add(mov)
                            }
                            completionHandler(moviesList as? [FMMovie], nil)
                        }
                        else
                        {
                            let error = NSError(domain: "kFMMovieErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error fetching the details from the server"])
                            completionHandler(nil, error)
                        }
                        print("responseDictionary: \(moviesList)")
                    }
                }else{
                    let error = NSError(domain: "kFMMovieErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error fetching the details from the server"])
                    completionHandler(nil, error)
                }
        });
        task.resume()
    }
    
}
