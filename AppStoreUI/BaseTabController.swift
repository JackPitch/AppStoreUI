//
//  BaseTabController.swift
//  AppStoreUI
//
//  Created by Jackson Pitcher on 12/26/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit

class BaseTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewControllers = [
            createViewController(viewController: MusicViewController(), title: "Music", imageName: "music"),
            createViewController(viewController: TodayViewController(), title: "Today", imageName: "today_icon"),
            createViewController(viewController: AppsViewController(), title: "Apps", imageName: "apps"),
            createViewController(viewController: SearchViewController(), title: "Search", imageName: "search"),
        ]
    }
    
    fileprivate func createViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        
        return navController
    }
}
