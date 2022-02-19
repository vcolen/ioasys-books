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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.scrollView.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        
        self.customView.setOnClickListener {
            self.view.endEditing(true)
        }
        setupButtonsActions()
        setupPageDescriptionView()
        bookCatalogueViewModel = BookCatalogueViewModel(authorization: self.authorization)
        bookCatalogueViewModel.didSucceedInLogin {books, totalPages, error in
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
        view = customView
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        clearCatalogue()
        currentPage = 2
        loadBooksInUI(books: self.defaultBooks)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        books = defaultBooks
    }
    fileprivate func setupButtonsActions() {
        customView.navigationTitleView.logOutButton.addAction(UIAction {_ in
            self.logOut()
        }, for: .touchUpInside)
        
        customView.searchbarView.searchButton.addAction( UIAction {_ in
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
    
    func clearCatalogue() {
        customView.bookStackView.removeFullyAllArrangedSubviews()
    }
    
    func logOut() {
        clearCatalogue()
        let loginScreen = LoginViewController()
        self.navigationController?.setViewControllers([loginScreen], animated: true)
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
    
    func presentDetailView(of book: BookDetailViewModel) {
        let bookDetailViewController = BookDetailViewController()
        bookDetailViewController.overrideUserInterfaceStyle = .light
        
        bookDetailViewController.viewModel = book
        
        present(bookDetailViewController, animated: true)
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
}

extension BookCatalogueViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > scrollView.contentSize.height - 100 - scrollView.frame.size.height {
            bookCatalogueViewModel.loadBooksOnPage(page: self.currentPage) { newBooks, page in
                if newBooks != nil && !newBooks!.isEmpty {
                    if !self.books.contains(where: {$0.info == newBooks![0].info} ) {
                        self.books += newBooks!
                        self.currentPage += 1
                        DispatchQueue.main.async {
                            self.loadBooksInUI(books: newBooks!)
                        }
                    }
                }
            }
        }
    }
}

