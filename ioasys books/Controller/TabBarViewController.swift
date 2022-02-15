//
//  TabBarViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 10/02/22.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var authorization: String?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        viewControllers = [
            createBookCatalogueView(),
            createBookmarkedBooksView()
        ]
    }
    
    func createBookCatalogueView() -> UINavigationController {
        let bookCatalogueViewController = BooksCatalogueViewController()
        bookCatalogueViewController.user = self.user
        bookCatalogueViewController.authorization = self.authorization ?? ""
        let bookCatalogueNavigationController = UINavigationController(rootViewController: bookCatalogueViewController)
        bookCatalogueNavigationController.tabBarItem.title = "Início"
        bookCatalogueNavigationController.tabBarItem.image = UIImage(systemName: "house.fill")
        
        return bookCatalogueNavigationController
    }
    
    func createBookmarkedBooksView() -> UINavigationController {
        let bookmarkedBooksViewController = BookmarkedBooksViewController()
        let bookmarkedBooksNavigationController = UINavigationController(rootViewController: bookmarkedBooksViewController)
        bookmarkedBooksNavigationController.tabBarItem.title = "Favoritos"
        bookmarkedBooksNavigationController.tabBarItem.image = UIImage(systemName: "bookmark.fill")
        
        return bookmarkedBooksNavigationController
    }
}
