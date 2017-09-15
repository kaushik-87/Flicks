//
//  ViewController.swift
//  Flicks
//
//  Created by Kaushik on 9/13/17.
//  Copyright © 2017 Dev. All rights reserved.
//

import UIKit
import AFNetworking
class FMNowPlayingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var nowPlayingMoviesTableView: UITableView!
    
    var movies = [FMMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let movieManager = FMMoviesManager.sharedManager
        self.nowPlayingMoviesTableView.rowHeight = 150
        movieManager.fetchNowPlayingMovies { (movies, error) in
        
            print(movies.count)
            if (error == nil){
                self.movies = movies
                self.nowPlayingMoviesTableView.reloadData()
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! FMMovieCell
        print(self.movies[indexPath.row].title)
        let movie =  self.movies[indexPath.row]
        cell.movieTitle.text = movie.title
        cell.overviewTextView.text = movie.overView
        print(movie.posterPath)
        if let imgURL = NSURL(string:"http://image.tmdb.org/t/p/w92\(movie.posterPath)")
        {
            print(imgURL)
            cell.posterImageView.setImageWith(imgURL as URL)
        }

        return cell
    }

}

