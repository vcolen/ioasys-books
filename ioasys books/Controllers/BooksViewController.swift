//
//  BooksViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit

class BooksViewController: UIViewController {
    
    lazy var viewCustom = BooksCatalogueView()
    var authorization = ""
    var books = [Book]()
    
    override func loadView() {
        super.loadView()
        
        view = viewCustom
        loadBooks()
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
    
    func lb() {
        for book in self.books {
            let view = BookContainerView()
            view.bookmarkButton.setImage(UIImage(systemName: Bool.random() ? "bookmark" : "bookmark.fill"), for: .normal)
            view.layer.cornerRadius = 4
            view.layer.shadowRadius = 24
            view.layer.shadowOffset = CGSize(width: 0, height: 4)
            view.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.09)
            view.layer.shadowOpacity = 1.0
            view.bookTitleLabel.text = book.title
            view.bookPageCountLabel.text = "\(book.pageCount) Páginas"
            view.bookAuthorLabel.text = book.authors.joined(separator: ", ")
            view.bookmarkButton.addAction(UIAction { _ in
                view.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                view.bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .selected)
            }, for: .touchUpInside)
            self.viewCustom.bookStackView.addArrangedSubview(view)
        }
        
        for view in viewCustom.bookStackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 160),
                view.widthAnchor.constraint(equalTo: viewCustom.bookStackView.widthAnchor)
            ])
        }
    }
    
    func loadBooks() {
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
                                self.lb()
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


