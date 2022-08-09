//
//  ViewController.swift
//  BigFlix
//
//  Created by Daval Cato on 7/30/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        // instantize tabbar
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpComingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        let vc5 = UINavigationController(rootViewController: ProfileViewController())
        
        
        // tabbar items
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        vc5.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        vc1.title = "Home"
        vc2.title = "Coming Some"
        vc3.title = "Searches"
        vc4.title = "Downloads"
        vc5.title = "Profile"
        
        tabBar.tintColor = .label
        
        // create array of vc
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
        
    }


}

