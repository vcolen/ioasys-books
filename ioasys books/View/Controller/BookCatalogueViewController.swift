//
//  BookCatalogueViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit
import SDWebImage

class BookCatalogueViewController: UIViewController {
    
    var customView = BooksCatalogueView()
    var userViewModel: UserViewModel!
    var page: Int!
    private var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.scrollView.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        
        self.page = 2
        setupButtonsActions()
        setupPageDescriptionView()
        view = customView
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customView.bookStackView.removeFullyAllArrangedSubviews()
        didSucceedInLogin()
        self.navigationItem.hidesBackButton = true
    }
    
    fileprivate func setupButtonsActions() {
        customView.navigationTitleView.logOutButton.addAction(UIAction {_ in
            self.logOut()
        }, for: .touchUpInside)
        
        
        customView.searchbarView.searchButton.addAction( UIAction {_ in
            self.searchBook()
        }, for: .touchUpInside)
    }
    
    fileprivate func loadBooksInUI(books: [Book]) {
        
        for book in books {
            let view = customizeBookContainerView(with: book)
            customView.bookStackView.addArrangedSubview(view)
        }
        
        customizeBookStackView()
    }
    
    func searchBook() {
        if let bookTitle = customView.searchbarView.searchBarTextField.text {
            Network.fetchBooksByTitle(bookTitle: bookTitle, authorization: self.userViewModel.authorization) { data, response, error in
                if let error = error {
                    print(error)
                } else {
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode == 200 {
                            do {
                                let safeData = try JSONDecoder().decode(Response.self, from: data!)
                                self.books = safeData.data
                                self.page = 1
                                DispatchQueue.main.async {
                                    self.customView.bookStackView.removeFullyAllArrangedSubviews()
                                    self.loadBooksInUI(books: self.books)
                                }
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            }
        } else {
            self.page = 1
            loadBooksInUI(books: self.books)
        }
    }
    
    func setupPageDescriptionView() {
        self.customView.pageDescriptionView.regularFontLabel.text = self.userViewModel?.gender == "M" ? "Bem vindo, " : "Bem vinda, "
        self.customView.pageDescriptionView.mediumFontLabel.text = (self.userViewModel?.name)! + "!"
    }
    
    func didSucceedInLogin() {
        Network.fetchBooks(authorization: self.userViewModel.authorization) { data, response, error in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            let safeData = try JSONDecoder().decode(Response.self, from: data!)
                            self.books = safeData.data
                            DispatchQueue.main.async {
                                self.loadBooksInUI(books: self.books)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    func logOut() {
        let loginScreen = LoginViewController()
        self.navigationController?.setViewControllers([loginScreen], animated: true)
    }
    
    func presentDetailView(of book: Book) {
        let bookDetailViewController = BookDetailViewController()
        let bookDetailViewModel = BookDetailViewModel(of: book)
        bookDetailViewController.viewModel = bookDetailViewModel
        
        present(bookDetailViewController, animated: true)
    }
    
    func customizeBookContainerView(with book: Book) -> BookContainerView {
        let viewModel = BookContainerViewModel(book: book)
        let view = BookContainerView()
        
        view.coverImageView.sd_setImage(with: viewModel.coverImageUrl)
        view.titleLabel.text = viewModel.title
        view.authorNameLabel.text = viewModel.authors
        
        for info in viewModel.info {
            let infoLabel = UILabel()
            infoLabel.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
            infoLabel.font = .heebo(ofSize: 12)
            infoLabel.text = info
            
            view.secondaryInfoStackView.addArrangedSubview(infoLabel)
        }
        
        view.bookmarkButton.imageView?.image = UIImage(
            named: viewModel.isBookmarked ? K.Images.isBookmarked : K.Images.isNotBookmarked
        )
        
        view.bookmarkButton.addAction(UIAction { _ in
            BookmarkedBooks().toggleBookmarkStatus(book: book)
            self.setBookmarkButtonImage(for: view.bookmarkButton, in: book)
        }, for: .touchUpInside)
        
        view.setOnClickListener {
            self.presentDetailView(of: book)
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
    
    func setBookmarkButtonImage(for button: UIButton, in book: Book) {
        if book.isBookmarked {
            button.setImage(UIImage(named: "Bookmarked Icon"), for: .normal)
        } else {
            button.setImage(UIImage(named: "Bookmark Icon"), for: .normal)
        }
    }
    
    func loadBooksOnPage(page: Int) {
        Network.fetchBooksWithPagination(page: page, authorization: self.userViewModel.authorization) { data, response, error in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            let safeData = try JSONDecoder().decode(Response.self, from: data!)
                            if !self.books.contains(safeData.data.first!) && self.page < 34 {
                                self.books += safeData.data
                                self.page += 1
                                DispatchQueue.main.async {
                                    self.loadBooksInUI(books: safeData.data)
                                }
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
}

extension BookCatalogueViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > scrollView.contentSize.height - 1000 - scrollView.frame.size.height {
            self.loadBooksOnPage(page: self.page)
        }
    }
}

