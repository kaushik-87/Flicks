//
//  ViewController.swift
//  Flicks
//
//  Created by Kaushik on 9/13/17.
//  Copyright © 2017 Dev. All rights reserved.
//

import UIKit

class FMNowPlayingViewController: UIViewController {
    @IBOutlet weak var nowPlayingMoviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let movieManager = MoviesManager.sharedManager
        movieManager.fetchNowPlayingMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

