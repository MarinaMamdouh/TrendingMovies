//
//  AppDelegate.swift
//  TrendingMovies
//
//  Created by Marina on 14/06/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.invokeFirstViewController()
        return true
    }
    
    private func invokeFirstViewController() {
        window =  UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let movieListViewController = MoviesListViewController()
        let mainNavigationController =  UINavigationController(rootViewController: movieListViewController)
        mainNavigationController.navigationBar.prefersLargeTitles = true
        window?.rootViewController = mainNavigationController
    }

}
