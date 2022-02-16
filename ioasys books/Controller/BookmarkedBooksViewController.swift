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
        
        setupButtonsActions()
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
        for book in BookmarkedBooks().books {
            let view = customizeBookContainerView(with: book.value)
            customView.bookStackView.addArrangedSubview(view)
        }
        customizeBookStackView()
    }
    
    func customizeBookContainerView(with book: Book) -> BookContainerView {
        let viewModel = BookContainerViewModel(book: book)
        let view = BookContainerView()
        
        view.coverImageView.sd_setImage(with: viewModel.coverImageUrl)
        view.titleLabel.text = viewModel.title
        view.pageCountLabel.text = viewModel.pageCount
        view.authorNameLabel.text = viewModel.authors
        view.publishDateLabel.text = viewModel.publishedDate
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
    
    func presentDetailView(of book: Book) {
        let bookDetailViewController = BookDetailViewController()
        let bookDetailViewModel = BookDetailViewModel(of: book)
        bookDetailViewController.viewModel = bookDetailViewModel
        
        present(bookDetailViewController, animated: true)
    }
    
    fileprivate func setupButtonsActions() {
          customView.navigationTitleView.logOutButton.addAction(UIAction {_ in
              self.logOut()
          }, for: .touchUpInside)
          
          
          customView.searchButton.addAction( UIAction {_ in
              //self.searchInBookmarkedBooks()
          }, for: .touchUpInside)
      }
    
    func logOut() {
        let loginScreen = LoginViewController()
        self.navigationController?.setViewControllers([loginScreen], animated: true)
    }
    
//    func searchInBookmarkedBooks() {
//        Network.fetchBooksByTitle(bookTitle: customView.searchBarTextField.text ?? "", authorization: self.authorization) { data, response, error in
//            if let error = error {
//                print(error)
//            } else {
//                if let response = response as? HTTPURLResponse {
//                    if response.statusCode == 200 {
//                        do {
//                            let safeData = try JSONDecoder().decode(Response.self, from: data!)
//                            self.books = safeData.data
//                            DispatchQueue.main.async {
//                                self.loadBooksInUI(books: self.books)
//                            }
//                        } catch {
//                            print(error)
//                        }
//                    }
//                }
//            }
//        }
//    }
}

