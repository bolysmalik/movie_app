//
//  UITabBar.swift
//  moviedb
//
//  Created by Bolys Malik on 06.11.2024.
//

import UIKit

class UserTabBarController: UITabBarController {
    
    override func viewDidLoad(){
    super.viewDidLoad()
         
        configureTabs()
    }
    private func configureTabs(){
        let vc1 = ViewController()
        let vc2 = FavViewController()
        let vc3 = WatchViewController()
        let vc4 = SearchViewController()
        let vc5 = ProfileViewController()

        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "star.fill")
        vc3.tabBarItem.image = UIImage(systemName: "eye.fill")
        vc4.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc5.tabBarItem.image = UIImage(systemName: "person")

        
        vc1.tabBarItem.title = "Home"
        vc2.tabBarItem.title = "Favorites"
        vc3.tabBarItem.title = "Watch list"
        vc4.tabBarItem.title = "Find"
        vc5.tabBarItem.title = "Profile"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        let nav5 = UINavigationController(rootViewController: vc5)

        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray6
        
        setViewControllers([nav1,nav2,nav3,nav4,nav5], animated: true)

    }
}
