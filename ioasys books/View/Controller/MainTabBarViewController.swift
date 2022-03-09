//
//  TabBarViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 10/02/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    var authorization: String!
    var userViewModel: UserViewModel!
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupViewControllers()
        overrideUserInterfaceStyle = .light
    }
        
    func setupViewControllers() {
        viewControllers = [
            createTestBookmarkedBooksView(),
            createBookmarkedBooksView()
        ]
    }
        
    func createBookCatalogueView() -> UINavigationController {
        let bookCatalogueViewController = BookCatalogueViewController()
        bookCatalogueViewController.userViewModel = self.userViewModel
        bookCatalogueViewController.authorization = self.authorization
        
        let bookCatalogueNavigationController = UINavigationController(rootViewController: bookCatalogueViewController)
        bookCatalogueNavigationController.tabBarItem.title = "Início"
        bookCatalogueNavigationController.tabBarItem.image = UIImage(systemName: "house.fill")
        
        return bookCatalogueNavigationController
    }
    
    func createBookmarkedBooksView() -> UINavigationController {
        let bookmarkedBooksViewController = BookmarkedBooksViewController()
        bookmarkedBooksViewController.authorization = self.authorization
        
        let bookmarkedBooksNavigationController = UINavigationController(rootViewController: bookmarkedBooksViewController)
        bookmarkedBooksNavigationController.tabBarItem.title = "Favoritos"
        bookmarkedBooksNavigationController.tabBarItem.image = UIImage(systemName: "bookmark.fill")
        
        return bookmarkedBooksNavigationController
    }
    
    func createTestBookmarkedBooksView() -> UINavigationController {
        let bookmarkedBooksViewController = TestViewController()
        bookmarkedBooksViewController.authorization = self.authorization
        
        let bookmarkedBooksNavigationController = UINavigationController(rootViewController: bookmarkedBooksViewController)
        bookmarkedBooksNavigationController.tabBarItem.title = "Favoritos"
        bookmarkedBooksNavigationController.tabBarItem.image = UIImage(systemName: "bookmark.fill")
        
        return bookmarkedBooksNavigationController
    }
}
