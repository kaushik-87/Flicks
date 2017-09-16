//
//  ViewController.swift
//  Flicks
//
//  Created by Kaushik on 9/13/17.
//  Copyright © 2017 Dev. All rights reserved.
//

import UIKit
import AFNetworking
class FMNowPlayingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let searchView: UISearchBar = UISearchBar.init(frame: CGRect(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: self.view.frame.size.width, height: 44 )))
        searchView.delegate = self
//        searchView.tintColor = UIColor.clear
        
//        searchView.searchBarStyle = UISearchBarStyle.prominent
//       searchView.isTranslucent = false
//        let textFieldInsideSearchBar = searchView.value(forKey: "searchField") as? UITextField
//        textFieldInsideSearchBar?.backgroundColor = UIColor.white
        searchView.barTintColor = UIColor.white
        self.navigationItem.titleView = searchView
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue)
        if(segue.identifier == "MovieDetails") {
            
            let vc = segue.destination as! FMMovieDetailsViewController
            if let cell = sender as? FMMovieCell{
                vc.loadDetails(movie: self.movies[(self.nowPlayingMoviesTableView.indexPath(for: cell)?.row)!])
            }
            
            
        }
    }
    
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {// called when text starts editing
        
    }
        
    
    public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        // return NO to not resign first responder
        return true
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // called when text ends editing
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {// called when text changes (including clear)
    }
    
    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{ // called before text changes
        return true
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {// called when keyboard search button pressed
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()

    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {// called when cancel button pressed
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let searchBar = self.navigationItem.titleView as? UISearchBar
        searchBar?.showsCancelButton = false
        searchBar?.resignFirstResponder()
        
    }


}

