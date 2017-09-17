//
//  FMMovieDetailsViewController.swift
//  Flicks
//
//  Created by Kaushik on 9/15/17.
//  Copyright © 2017 Dev. All rights reserved.
//

import UIKit
import AFNetworking
class FMMovieDetailsViewController: UIViewController {
    @IBOutlet weak var contentBackGroundView: UIView!
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var movieVote: UILabel!
    @IBOutlet weak var overviewScrollView: UIScrollView!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    var movie: FMMovie? = nil
    override func viewDidLoad() {

        super.viewDidLoad()
        print(self.movie?.backdropPath ?? "")
        if let backDropPath =  self.movie?.backdropPath{
            let imgURL = NSURL(string:"http://image.tmdb.org/t/p/w500\(backDropPath)")
            self.backDropImageView.setImageWith(imgURL! as URL)
        }

        if let overView = self.movie?.overView {
            self.movieOverview.text = overView
        }
        
        if let title = self.movie?.origTitle {
            self.movieTitle.text = title
        }
        
        if let releaseDate = self.movie?.releaseDate {
            self.movieReleaseDate.text = releaseDate
        }
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDetails(movie : FMMovie) -> Void {

        self.movie = movie
        
//        if let backDropPath = self.movie?.backdropPath
//        {
//            if let imgURL = NSURL(string:"http://image.tmdb.org/t/p/w92\(movie.backdropPath)")
//            {
//                print(imgURL)
//                self.backDropImageView.setImageWith(imgURL as URL)
//            }
//        }
        
        //print(self.movie?.origTitle)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
