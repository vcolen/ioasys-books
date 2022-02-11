//
//  TabBarViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 10/02/22.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVCs()
    }
    func createNavController(for rootViewController: UIViewController,
                             title: String,
                             image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        
        return navController
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: BooksCatalogueViewController(), title: NSLocalizedString("Início", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: BooksCatalogueViewController(), title: NSLocalizedString("Favoritos", comment: ""), image: UIImage(systemName: "bookmark.fill")!)
        ]
    }
}
