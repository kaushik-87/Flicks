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
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var overviewScrollView: UIScrollView!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var voteAvg: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    var movie: FMMovie? = nil
    override func viewDidLoad() {

        super.viewDidLoad()
        print(self.movie?.backdropPath ?? "")

        // Do any additional setup after loading the view.
        
        
    }
    
    @objc func backBarbuttonAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let leftBarButtonItem = UIBarButtonItem(title: "Movies", style: .plain, target: self, action: #selector(backBarbuttonAction))
        leftBarButtonItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
//        self.navigationController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        if let backDropPath =  self.movie?.backdropPath{
            let imgURL = NSURL(string:"http://image.tmdb.org/t/p/w45\(backDropPath)")
            self.backDropImageView.setImageWith(imgURL! as URL)
        }
        
        if let overView = self.movie?.overView {
            self.movieOverview.text = overView
        }
        
        if let title = self.movie?.origTitle {
            self.movieTitle.text = title
        }
        
        if let voteAvg = self.movie?.voteAvg {
            self.voteAvg.text = voteAvg
        }
        
        
        if let releaseDate = self.movie?.releaseDate {
            self.movieReleaseDate.text = dateInStringFormat(releaseDate: releaseDate)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let backDropPath =  self.movie?.backdropPath{
            let imgURL = NSURL(string:"http://image.tmdb.org/t/p/original\(backDropPath)")
            self.backDropImageView.setImageWith(imgURL! as URL)
        }
    }

    
    func dateInStringFormat(releaseDate : String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: releaseDate)
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateStyle = .medium
        newDateFormatter.timeStyle = .none
        newDateFormatter.locale = Locale(identifier: "en_US")
        
        return newDateFormatter.string(from: date!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDetails(movie : FMMovie) -> Void {

        self.movie = movie
        
        
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
