//
//  TestViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 07/03/22.
//

import UIKit

class TestViewController: UIViewController {
    let tableView = UITableView()
    let searchController = UISearchController()
    
    var authorization: String!
    var userViewModel: UserViewModel!
    var currentPage: Int!
    var bookCatalogueViewModel: BookCatalogueViewModel!
    private var books = [BookViewModel]()
    private var totalPages: Float!
    
    func setNavigationBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.barTintColor = .white
        let logoutButton = UIBarButtonItem(image: UIImage(named: "Log Out Icon"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(logout))
        logoutButton.tintColor = .gray
        navigationItem.rightBarButtonItem = logoutButton
        
        self.navigationItem.titleView = NavigationTitleView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.currentPage = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        bookCatalogueViewModel = BookCatalogueViewModel(authorization: self.authorization)
        didSucceedInLogin()
    }
    
    override func loadView() {
        super.loadView()
        
        self.setNavigationBar()
        view.addSubview(tableView)
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(BookCell.self, forCellReuseIdentifier: "joga")
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func logout() {
        let loginScreen = LoginViewController()
        self.navigationController?.setViewControllers([loginScreen], animated: true)
    }
    
    fileprivate func didSucceedInLogin() {
        bookCatalogueViewModel.didSucceedInLogin { books, totalPages, error in
            guard let books = books else {
                return
            }
            
            guard let totalPages = totalPages else {
                return
            }
            
            //self.defaultBooks = books
            self.books = books
            self.totalPages = totalPages
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func presentDetailView(of book: BookDetailViewModel) {
        let bookDetailViewController = BookDetailViewController()
        bookDetailViewController.overrideUserInterfaceStyle = .light
        
        bookDetailViewController.bookDetailViewModel = book
        
        present(bookDetailViewController, animated: true)
    }
}

extension TestViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        let bookDetailViewModel = book.getDetailViewModelVersion()
        self.presentDetailView(of: bookDetailViewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == self.books.count - 5 {
            
            bookCatalogueViewModel.loadBooksOnPage(page: self.currentPage) { newBooks, page in
                if let newBooks = newBooks {
                    if !newBooks.isEmpty {
                        //checking if the same page wasnt downloaded twice
                        if !self.books.contains(where: {$0.info == newBooks[0].info} ) {
                            self.books += newBooks
                            self.currentPage += 1
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
            
        }
    }
}

extension TestViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "joga", for: indexPath) as! BookCell
        let book = books[indexPath.row]
        cell.configure(book: book)
        
        return cell
    }
}

