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
        
        view = viewCustom
        didSucceedInLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func fetchBooks(completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        let url = URL(string: K.URLs.books + "page=1")
        var getRequest = URLRequest(url: url!)
        getRequest.addValue("Bearer \(authorization)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: getRequest) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    func loadBooksInUI() {
        for book in self.books {
            let view = BookContainerView()
            
            view.bookCoverImageView.sd_setImage(with: URL(string: book.imageUrl ?? "https://d2drtqy2ezsot0.cloudfront.net/Book-0.jpg"))
            view.bookTitleLabel.text = book.title
            view.bookPageCountLabel.text = "\(book.pageCount) Páginas"
            view.bookAuthorLabel.text = book.authors.joined(separator: ", ")
            
            //view.bookmarkButton.setImage(UIImage(systemName: Bool.random() ? "bookmark" : "bookmark.fill"), for: .normal)
            //view.bookmarkButton.addAction(UIAction { _ in
            //  view.bookmarkButton.setImage(UIImage(systemName: view.bookmarkButton.imageView?.image == UIImage(systemName: "bookmark") ? "bookmark.fill" : "bookmark"), for: .normal)
            //}, for: .touchUpInside)
            
            //            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.loadDetailView))
            //            view.addGestureRecognizer(gesture)
            
            
            view.setOnClickListener {
                self.loadDetailView(of: book)
            }
            
            
            viewCustom.bookStackView.addArrangedSubview(view)
            
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
    
    func loadDetailView(of book: Book) {
            // Create the view controller.
            let sheetViewController = BookDetailViewController()
            
            // Present it w/o any adjustments so it uses the default sheet presentation.
            present(sheetViewController, animated: true, completion: nil)
        }
}



