//
//  TabBarViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 10/02/22.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    
    var authorization = ""
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    func createNavigationController(for rootViewController: UIViewController,
                             title: String,
                             image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
    
    func setupViewControllers() {
        viewControllers = [
            createNavigationController(for: BooksCatalogueViewController(), title: NSLocalizedString("Início", comment: ""), image: UIImage(systemName: "house")!),
            createNavigationController(for: BooksCatalogueViewController(), title: NSLocalizedString("Favoritos", comment: ""), image: UIImage(systemName: "bookmark.fill")!)
        ]
    }
}
