//
//  BookmarkedBooksViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 11/02/22.
//

import UIKit

class BookmarkedBooksViewController: UIViewController {
    
    var customView = BooksCatalogueView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after oading the view.
        
    }
    
    override func loadView() {
        super.loadView()
        
        setupPageDescriptionView()
        view = customView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadBooksInUI()
    }
    
    func setupPageDescriptionView() {
        self.customView.pageDescriptionView.regularFontLabel.text = "Aqui estão os seus "
        self.customView.pageDescriptionView.mediumFontLabel.text = "favoritos"
    }
    
    func loadBooksInUI() {
        
        customView.bookStackView.removeFullyAllArrangedSubviews()
        
        if let tabbar = self.tabBarController as? TabBarViewController {
            for book in tabbar.bookmarkedBooks.books {
                let view = customizeBookContainerView(with: book.value)
                customView.bookStackView.addArrangedSubview(view)
            }
        }
        customizeBookStackView()
    }
    
    func customizeBookContainerView(with book: Book) -> BookContainerView {
        let view = BookContainerView()
        view.coverImageView.sd_setImage(with: URL(string: book.imageUrl ?? "https://d2drtqy2ezsot0.cloudfront.net/Book-0.jpg"))
        view.titleLabel.text = book.title
        view.pageCountLabel.text = "\(book.pageCount) Páginas"
        view.authorNameLabel.text = book.authors.joined(separator: ", ")
        
        if let tabbar = self.tabBarController as? TabBarViewController {
            tabbar.setBookmarkButtonImage(for: view.bookmarkButton, in: book)
        }
        
        view.bookmarkButton.addAction(UIAction { _ in
            if let tabbar = self.tabBarController as? TabBarViewController {
                tabbar.changeBookmarkedStatus(view.bookmarkButton, book: book)
            }
        }, for: .touchUpInside)
        
        view.setOnClickListener {
            self.loadDetailView(of: book)
        }
        
        return view
    }
    
    func customizeBookStackView() {
        for view in customView.bookStackView.arrangedSubviews {
            view.layer.cornerRadius = 4
            view.layer.shadowRadius = 24
            view.layer.shadowOffset = CGSize(width: 0, height: 4)
            view.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.09)
            view.layer.shadowOpacity = 1.0
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 160),
                view.widthAnchor.constraint(equalTo: customView.bookStackView.widthAnchor)
            ])
        }
    }
    
    func loadDetailView(of book: Book) {
        let bookDetailViewController = BookDetailViewController()
        bookDetailViewController.book = book
        
        present(bookDetailViewController, animated: true)
    }
}

