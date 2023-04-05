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
        createNavController(viewController: NewsController(), title: "NEWS")
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
//        navController.navigationBar.topAnchor = view.topAnchor
        
//        navController.navigationBar.backgroundColor = .white
        viewController.navigationItem.title = title
        return navController
    }


}
