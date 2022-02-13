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
    var bookmarkedBooks = BookmarkedBooks()
    
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
        bookCatalogueNavigationController.tabBarItem.image = UIImage(systemName: "house")
        
        return bookCatalogueNavigationController
    }
    
    func createBookmarkedBooksView() -> UINavigationController {
        let bookmarkedBooksViewController = BookmarkedBooksViewController()
        let bookmarkedBooksNavigationController = UINavigationController(rootViewController: bookmarkedBooksViewController)
        bookmarkedBooksNavigationController.tabBarItem.title = "Favoritos"
        bookmarkedBooksNavigationController.tabBarItem.image = UIImage(systemName: "bookmark.fill")
        
        return bookmarkedBooksNavigationController
    }
    
    
    func changeBookmarkedStatus(_ sender: UIButton, book: Book) {
        if self.bookmarkedBooks.books[book.id] == book {
            self.bookmarkedBooks.books[book.id] = nil
        } else {
            self.bookmarkedBooks.books[book.id] = book
        }
        setBookmarkButtonImage(for: sender, in: book)
    }
    
    func setBookmarkButtonImage(for button: UIButton, in book: Book) {
        if self.bookmarkedBooks.books[book.id] == book {
            button.setImage(UIImage(named: "Bookmarked Icon"), for: .normal)
        } else {
            button.setImage(UIImage(named: "Bookmark Icon"), for: .normal)
        }
    }
}
