//
//  ViewController.swift
//  Flicks
//
//  Created by Kaushik on 9/13/17.
//  Copyright © 2017 Dev. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
class FMMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,  UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBAction func segmentControlAction(_ sender: Any) {
        let segmentControl = sender as! UISegmentedControl
        switch segmentControl.selectedSegmentIndex {
        case 1:
            // load collection view to show grid view
            showListView(show: false)
            break
            
        default:
                //  load table view to show list view
            showListView(show: true)

        }
    }
    
    func showListView(show : Bool) -> Void{
        if show {
            self.moviesCollectionView.isHidden = true
            self.moviesTableView.isHidden = false
            self.moviesTableView.insertSubview(refreshControl, at: 0)

            return
        }
        self.moviesCollectionView.isHidden = false
        self.moviesTableView.isHidden = true
        self.moviesCollectionView.insertSubview(collectionViewRefreshControl, at: 0)

    }
    
    @IBOutlet weak var viewSelectionSegmentControl: UISegmentedControl!
    @IBOutlet weak var networkErrorView: UIView!
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var isNowPlaying: Bool = true
    var movies = [FMMovie]()
    var searchActive : Bool = false
    var filteredMovies = [FMMovie]()
    let refreshControl = UIRefreshControl()
    let collectionViewRefreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkErrorView.isHidden = true
        showListView(show: true)

        // Do any additional setup after loading the view, typically from a nib.
        let searchView: UISearchBar = UISearchBar.init(frame: CGRect(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: (self.navigationController?.navigationBar.frame.size.width)! + 40, height: 44 )))
        searchView.delegate = self
        //        searchView.tintColor = UIColor.clear
        
        //        searchView.searchBarStyle = UISearchBarStyle.prominent
        //       searchView.isTranslucent = false
        //        let textFieldInsideSearchBar = searchView.value(forKey: "searchField") as? UITextField
        //        textFieldInsideSearchBar?.backgroundColor = UIColor.white
        
        searchView.barTintColor = UIColor(red:0.94, green:0.71, blue:0.25, alpha:1.0)
        self.navigationItem.titleView = searchView

        refreshControl.backgroundColor = UIColor.clear
        collectionViewRefreshControl.backgroundColor = UIColor.clear
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        collectionViewRefreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)

        prepareData()
        self.moviesTableView.rowHeight = 150
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        prepareData()
        
    }
    func prepareData()
    {
        let movieManager = FMMoviesManager.sharedManager
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if isNowPlaying {
            movieManager.fetchNowPlayingMovies { (movies, error) in
                
                if (error == nil){
                    self.movies = movies!
                    self.moviesTableView.reloadData()
                    self.moviesCollectionView.reloadData()
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.refreshControl.endRefreshing()
                    self.collectionViewRefreshControl.endRefreshing()
                }else{
                    self.networkErrorView.isHidden = false
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.refreshControl.endRefreshing()
                    self.collectionViewRefreshControl.endRefreshing()
                }
                
            }
        }
        else {
            movieManager.fetchTopRatedMovies { (movies, error) in
                
                if (error == nil){
                    self.movies = movies!
                    self.moviesTableView.reloadData()
                    self.moviesCollectionView.reloadData()
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.refreshControl.endRefreshing()
                    self.collectionViewRefreshControl.endRefreshing()
                }else{
                    self.networkErrorView.isHidden = false
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.refreshControl.endRefreshing()
                    self.collectionViewRefreshControl.endRefreshing()

                }
                
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexpath = self.moviesTableView.indexPathForSelectedRow {
            self.moviesTableView.deselectRow(at: indexpath, animated: false)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return self.filteredMovies.count
        }
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! FMMovieCell
        print(self.movies[indexPath.row].title)
        var movie = FMMovie.init()
        if searchActive {
            movie = self.filteredMovies[indexPath.row]
        }
        else{
            movie =  self.movies[indexPath.row]
        }
        cell.movieTitle.text = movie.title
        cell.overviewLabel.text = movie.overView
        print(movie.posterPath)
        if let imgURL = NSURL(string:"http://image.tmdb.org/t/p/w500\(movie.posterPath)")
        {
            print(imgURL)
            cell.posterImageView.setImageWith(imgURL as URL)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int{
        if searchActive {
            return self.filteredMovies.count
        }
        return self.movies.count
        
    }
    
    internal func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! FMMovieCollectionViewCell
        print(self.movies[indexPath.row].title)
        var movie = FMMovie.init()
        if searchActive {
            movie = self.filteredMovies[indexPath.row]
        }
        else{
            movie =  self.movies[indexPath.row]
        }
        cell.movieTitleLabel.text = movie.origTitle
        print(movie.posterPath)
        if let imgURL = NSURL(string:"http://image.tmdb.org/t/p/w500\(movie.posterPath)")
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
                var selectedMovie = FMMovie.init()
                if searchActive {
                    selectedMovie = self.filteredMovies[(self.moviesTableView.indexPath(for: cell)?.row)!]
                }
                else{
                    selectedMovie = self.movies[(self.moviesTableView.indexPath(for: cell)?.row)!]

                }
                
                vc.loadDetails(movie: selectedMovie)
            }
            else if let cell = sender as? FMMovieCollectionViewCell{
                var selectedMovie = FMMovie.init()
                if searchActive {
                    selectedMovie = self.filteredMovies[(self.moviesCollectionView.indexPath(for: cell)?.row)!]
                }
                else{
                    selectedMovie = self.movies[(self.moviesCollectionView.indexPath(for: cell)?.row)!]
                    
                }
                
                vc.loadDetails(movie: selectedMovie)
            }
            
            
        }
    }
    
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {// called when text starts editing
        if (searchBar.text != "") {
            searchActive = true;
        }
        else{
            searchActive = false
            self.moviesTableView.reloadData()
            self.moviesCollectionView.reloadData()
        }
        
    }
        
    
    public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        // return NO to not resign first responder
        return true
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // called when text ends editing
        //searchActive = false;

    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {// called when text changes (including clear)
        
        self.filteredMovies = self.movies.filter({ (searchedmovie :FMMovie) -> Bool in
//            let tmpTitle: String = searchedmovie.origTitle ?? ""
//            let range = tmpTitle.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            
            return (searchedmovie.origTitle?.contains(searchText))!
        })
//            data.filter({ (text) -> Bool in
//            let tmp: NSString = text
//            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
//            return range.location != NSNotFound
//        })
//        if(self.filteredMovies.count == 0){
//            searchActive = false;
//        } else {
//            searchActive = true;
//        }
        
        if (searchBar.text == "") {
            searchActive = false
            self.moviesTableView.reloadData()
            self.moviesCollectionView.reloadData()
            return
        }
        
        searchActive = true
        print(self.filteredMovies.count)
        
        self.moviesTableView.reloadData()
        self.moviesCollectionView.reloadData()
        
        
    }
    
    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{ // called before text changes
        return true
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {// called when keyboard search button pressed
        searchBar.showsCancelButton = false
        searchActive = false;
        searchBar.text = ""
        searchBar.resignFirstResponder()

    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {// called when cancel button pressed
        searchBar.showsCancelButton = false
        searchActive = false;
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.moviesTableView.reloadData()
        self.moviesCollectionView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let searchBar = self.navigationItem.titleView as? UISearchBar
        searchBar?.showsCancelButton = false
        searchBar?.resignFirstResponder()
        
    }


}

