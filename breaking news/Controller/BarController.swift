//
//  barController.swift
//  breaking news
//
//  Created by Renat Nazyrov on 03.04.2023.
//

import UIKit

class BarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createNavController(viewController: BreakingNewsController(), title: "Top News"),
            createNavController(viewController: SearchController(), title: "Search")
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white //цвет меню
        tabBar.standardAppearance = appearance
        let itemAppearance = UITabBarItemAppearance()
        return navController
    }
}
