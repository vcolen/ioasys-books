//
//  BookCatalogueViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit
import SDWebImage

class BookCatalogueViewController: UIViewController {
    
    var authorization: String!
    var userViewModel: UserViewModel!
    var bookCatalogueViewModel: BookCatalogueViewModel!
    private let customView = BooksCatalogueView()
    private var books = [BookViewModel]()
    private var defaultBooks = [BookViewModel]()
    private var totalPages: Float!
    private var currentPage: Int!
    
    fileprivate func didSucceedInLogin() {
        bookCatalogueViewModel.didSucceedInLogin { books, totalPages, error in
            guard let books = books else {
                return
            }
            
            guard let totalPages = totalPages else {
                return
            }
            
            self.defaultBooks = books
            self.books = books
            self.totalPages = totalPages
            
            DispatchQueue.main.async {
                self.loadBooksInUI(books: self.defaultBooks)
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        setupButtonsActions()
        setupPageDescriptionView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.scrollView.delegate = self
        self.navigationItem.hidesBackButton = true
        bookCatalogueViewModel = BookCatalogueViewModel(authorization: self.authorization)
        didSucceedInLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        clearCatalogue()
        currentPage = 2
        loadBooksInUI(books: self.defaultBooks)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Then it's not needed to make an extra API call every time the view loads
        books = defaultBooks
    }
    
    fileprivate func setupButtonsActions() {
        customView.navigationTitleView.logOutButton.addAction(UIAction {_ in
            self.logOut()
        }, for: .touchUpInside)
        
        //Cancel keyboard when touching the view
        self.customView.setOnClickListener {
            self.view.endEditing(true)
        }
        
        customView.searchbarView.searchButton.addAction( UIAction {_ in
            self.searchButtonPressed()
        }, for: .touchUpInside)
    }
    
    fileprivate func loadBooksInUI(books: [BookViewModel]) {
        for book in books {
            let view = customizeBookContainerView(with: book)
            customView.bookStackView.addArrangedSubview(view)
        }
        customizeBookStackView()
    }
    
    fileprivate func setupPageDescriptionView() {
        self.customView.pageDescriptionView.regularFontLabel.text = self.userViewModel?.userGender == "M" ? "Bem vindo, " : "Bem vinda, "
        self.customView.pageDescriptionView.mediumFontLabel.text = (self.userViewModel?.userName)! + "!"
    }
    
    fileprivate func clearCatalogue() {
        customView.bookStackView.removeFullyAllArrangedSubviews()
    }
    
    fileprivate func logOut() {
        clearCatalogue()
        let loginScreen = LoginViewController()
        self.navigationController?.setViewControllers([loginScreen], animated: true)
    }
    
    fileprivate func customizeBookContainerView(with book: BookViewModel) -> BookContainerView {
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
        
        //Show the detail view of the book when pressed
        view.setOnClickListener {
            let bookDetailViewModel = book.getDetailViewModelVersion()
            self.presentDetailView(of: bookDetailViewModel)
        }
        
        return view
    }
    
    fileprivate func presentDetailView(of book: BookDetailViewModel) {
        let bookDetailViewController = BookDetailViewController()
        bookDetailViewController.overrideUserInterfaceStyle = .light
        
        bookDetailViewController.bookDetailViewModel = book
        
        present(bookDetailViewController, animated: true)
    }
    
    fileprivate func customizeBookStackView() {
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
    
    fileprivate func setBookmarkButtonImage(for button: UIButton, in book: BookViewModel) {
        if book.isBookmarked {
            button.setImage(UIImage(named: "Bookmarked Icon"), for: .normal)
        } else {
            button.setImage(UIImage(named: "Bookmark Icon"), for: .normal)
        }
    }
    
    fileprivate func searchButtonPressed() {
        self.view.endEditing(true)
        
        let bookTitle = self.customView.searchbarView.searchBarTextField.text ?? ""
        self.bookCatalogueViewModel.searchBook(bookTitle: bookTitle) {books, error in
            guard error == nil else {
                return
            }
            
            if let books = books {
                DispatchQueue.main.async {
                    self.books = books
                    self.clearCatalogue()
                    self.loadBooksInUI(books: self.books)
                }
            }
        }
    }
}

extension BookCatalogueViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > scrollView.contentSize.height - 100 - scrollView.frame.size.height {
            bookCatalogueViewModel.loadBooksOnPage(page: self.currentPage) { newBooks, page in
                if let newBooks = newBooks {
                    if !newBooks.isEmpty {
                        //checking if the same page wasnt downloaded twice
                        if !self.books.contains(where: {$0.info == newBooks[0].info} ) {
                            self.books += newBooks
                            self.currentPage += 1
                            DispatchQueue.main.async {
                                self.loadBooksInUI(books: newBooks)
                            }
                        }
                    }
                }
            }
        }
    }
}

