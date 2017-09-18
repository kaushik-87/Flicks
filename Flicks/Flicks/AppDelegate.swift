//
//  AppDelegate.swift
//  Flicks
//
//  Created by Kaushik on 9/13/17.
//  Copyright © 2017 Dev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let manager = FMMoviesManager.sharedManager
//        manager.fetchConfigurations()
        
        // Adding the tab bar programmtically to reuse the view controllers.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nowPlayingNavController:UINavigationController = storyboard.instantiateViewController(withIdentifier: "MoviesNavController") as! UINavigationController
        let nowPlayingViewController = nowPlayingNavController.topViewController as! FMMoviesViewController
        nowPlayingViewController.isNowPlaying = true
        nowPlayingNavController.navigationBar.barTintColor = UIColor(red:0.94, green:0.71, blue:0.25, alpha:1.0)
        nowPlayingNavController.navigationBar.isTranslucent = false
        nowPlayingNavController.tabBarItem.title = "Now Playing"
        nowPlayingNavController.tabBarItem.image = UIImage.init(named: "nowPlaying")
        nowPlayingNavController.tabBarItem.badgeColor = UIColor.black

        
        let topRatedNavController:UINavigationController = storyboard.instantiateViewController(withIdentifier: "MoviesNavController") as! UINavigationController
        let topRatedViewController = topRatedNavController.topViewController as! FMMoviesViewController
        topRatedViewController.isNowPlaying = false
        topRatedNavController.navigationBar.barTintColor = UIColor(red:0.94, green:0.71, blue:0.25, alpha:1.0)
        topRatedNavController.navigationBar.isTranslucent = false
        topRatedNavController.tabBarItem.title = "Top Rated"
        topRatedNavController.tabBarItem.image = UIImage.init(named: "topRated")
        topRatedNavController.tabBarItem.badgeColor = UIColor.black
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nowPlayingNavController, topRatedNavController]
        tabBarController.tabBar.tintColor = UIColor.black
        tabBarController.tabBar.barTintColor = UIColor(red:0.94, green:0.71, blue:0.25, alpha:1.0)
        tabBarController.tabBar.isTranslucent = false
        window?.rootViewController = tabBarController
        window?.becomeKey()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

