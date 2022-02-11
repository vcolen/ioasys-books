//
//  BooksViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit
import SDWebImage

class BooksCatalogueViewController: UIViewController {
    
    lazy var viewCustom = BooksCatalogueView()
    var authorization = ""
    var books = [Book]()
    
    
    override func loadView() {
        super.loadView()
        
        
        viewCustom.navigationTitleView.logOutButton.addAction(UIAction {_ in
            self.logOut()
        }, for: .touchUpInside)
        view = viewCustom
        didSucceedInLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.hidesBackButton = true
    }
    
    func fetchBooks(completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        let url = URL(string: K.URLs.books + "page=1")
        var getRequest = URLRequest(url: url!)
        getRequest.addValue("Bearer \(authorization)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: getRequest) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    func didSucceedInLogin() {
        fetchBooks { data, response, error in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            let safeData = try JSONDecoder().decode(Response.self, from: data!)
                            self.books = safeData.data
                            DispatchQueue.main.async {
                                self.loadBooksInUI()
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
    
    func loadDetailView(of book: Book) {
        let bookDetailViewController = BookDetailViewController()
        bookDetailViewController.book = book
        
        present(bookDetailViewController, animated: true, completion: nil)
    }
    
    func loadBooksInUI() {
        for book in self.books {
            let view = customizeBookContainerView(with: book)
            viewCustom.bookStackView.addArrangedSubview(view)
        }
        customizeBookStackView()
    }
    
    func customizeBookContainerView(with book: Book) -> BookContainerView {
        let view = BookContainerView()
        view.bookCoverImageView.sd_setImage(with: URL(string: book.imageUrl ?? "https://d2drtqy2ezsot0.cloudfront.net/Book-0.jpg"))
        view.bookTitleLabel.text = book.title
        view.bookPageCountLabel.text = "\(book.pageCount) Páginas"
        view.bookAuthorLabel.text = book.authors.joined(separator: ", ")
        view.bookmarkButton.setImage(UIImage(systemName: Bool.random() ? "bookmark" : "bookmark.fill"), for: .normal)
        
        view.bookmarkButton.addAction(UIAction { _ in
            self.toggleButtonImage(of: view.bookmarkButton, between: UIImage(systemName: "bookmark")!, and: UIImage(systemName: "bookmark.fill")!)
        }, for: .touchUpInside)
        
        view.setOnClickListener {
            self.loadDetailView(of: book)
        }
        
        return view
    }
    
    func customizeBookStackView() {
        for view in viewCustom.bookStackView.arrangedSubviews {
            view.layer.cornerRadius = 4
            view.layer.shadowRadius = 24
            view.layer.shadowOffset = CGSize(width: 0, height: 4)
            view.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.09)
            view.layer.shadowOpacity = 1.0
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 160),
                view.widthAnchor.constraint(equalTo: viewCustom.bookStackView.widthAnchor)
            ])
        }
    }
    
    func toggleButtonImage(of button: UIButton, between image1: UIImage, and image2: UIImage) {
        if button.imageView?.image == image1 {
            button.setImage(image2, for: .normal)
        } else {
            button.setImage(image1, for: .normal)
        }
    }
}



