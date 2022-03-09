//
//  BookmarkedBooksViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 11/02/22.
//

import UIKit
import SDWebImage

class BookmarkedBooksViewController: UIViewController {
    
    var customView = BooksCatalogueView()
    var bookmarkedBooksViewModel: BookmarkedBooksViewModel!
    var bookmarkedBooks = [BookViewModel]()
    var authorization: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtonsActions()
    }
    
    override func loadView() {
        super.loadView()
        
        self.customView.setOnClickListener {
            self.view.endEditing(true)
        }
        setupPageDescriptionView()
        view = customView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.bookmarkedBooksViewModel = BookmarkedBooksViewModel(authorization: self.authorization)
        loadBooksInUI(books: bookmarkedBooksViewModel.bookmarkedBooks)
    }
    
    func setupPageDescriptionView() {
        self.customView.pageDescriptionView.regularFontLabel.text = "Aqui estão os seus "
        self.customView.pageDescriptionView.mediumFontLabel.text = "favoritos"
    }
    
    func loadBooksInUI(books: [BookViewModel]) {
        clearBookmarkedBooks()
        for book in books {
            let view = customizeBookContainerView(with: book)
            customView.bookStackView.addArrangedSubview(view)
        }
        customizeBookStackView()
    }
    
    func clearBookmarkedBooks() {
        customView.bookStackView.removeFullyAllArrangedSubviews()
    }
    
    func customizeBookContainerView(with book: BookViewModel) -> BookContainerView {
        let view = BookContainerView()
        
        view.coverImageView.sd_setImage(with: book.coverImageUrl)
        view.titleLabel.text = book.title
        view.authorNameLabel.text = book.authors
        
        for info in book.info {
            let infoLabel = UILabel()
            infoLabel.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
            infoLabel.font = .heebo(ofSize: 12)
            infoLabel.text = info
            
            view.secondaryInfoStackView.addArrangedSubview(infoLabel)
        }
        
        view.bookmarkButton.setImage(UIImage(
            named: book.isBookmarked ? K.Images.isBookmarked : K.Images.isNotBookmarked
        ), for: .normal)
        
        view.bookmarkButton.addAction(UIAction { _ in
            book.changeBookmarkedStatus()
            self.setBookmarkButtonImage(for: view.bookmarkButton, in: book)
        }, for: .touchUpInside)
        
        view.setOnClickListener {
            let bookDetailViewModel = book.getDetailViewModelVersion()
            self.presentDetailView(of: bookDetailViewModel)
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
    
    func setBookmarkButtonImage(for button: UIButton, in book: BookViewModel) {
        if book.isBookmarked {
            button.setImage(UIImage(named: "Bookmarked Icon"), for: .normal)
        } else {
            button.setImage(UIImage(named: "Bookmark Icon"), for: .normal)
        }
    }
    
    func presentDetailView(of book: BookDetailViewModel) {
        let bookDetailViewController = BookDetailViewController()
        bookDetailViewController.overrideUserInterfaceStyle = .light
        
        bookDetailViewController.bookDetailViewModel = book
        
        present(bookDetailViewController, animated: true)
    }
    
    fileprivate func setupButtonsActions() {
        customView.navigationTitleView.logOutButton.addAction(UIAction {_ in
            self.logOut()
        }, for: .touchUpInside)
        
        customView.searchbarView.searchButton.addAction( UIAction {_ in
            self.bookmarkedBooksViewModel.searchBookmarkedBooks(bookTitle:
                                                                    self.customView.searchbarView.searchBarTextField.text ?? ""
            ) { bookmarkedBooks in
                self.loadBooksInUI(books: bookmarkedBooks)
            }
        }, for: .touchUpInside)
    }
    
    func logOut() {
        let loginScreen = LoginViewController()
        self.navigationController?.setViewControllers([loginScreen], animated: true)
    }
}

