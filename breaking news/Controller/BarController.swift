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
//            createNavController(viewController: BreakingNewsController(clickCount: 0), title: "Top News"),
            createNavController(viewController: BreakingNewsController(), title: "Top News"),
            createNavController(viewController: SearchController(), title: "Search")
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
//        navController.navigationBar.topAnchor = view.topAnchor
//        navController.navigationBar.backgroundColor = .white
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
//        tabBar.isTranslucent = false
//        tabBar.backgroundColor = .systemGreen
        
        let appearance = UITabBarAppearance()
//        appearance.backgroundColor = .systemGreen
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        let itemAppearance = UITabBarItemAppearance()
//        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navController
    }
}
