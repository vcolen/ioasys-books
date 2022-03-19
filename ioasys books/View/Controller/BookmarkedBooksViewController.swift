//
//  BookmarkedBooksViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit

class BookmarkedBooksViewController: UIViewController {
    let tableView = UITableView()
    let searchController = UISearchController()
    var bookmarkedBooksViewModel: BookmarkedBooksViewModel!
    var authorization: String!
    
    
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
        
        self.bookmarkedBooksViewModel = BookmarkedBooksViewModel(authorization: self.authorization)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        searchController.searchResultsUpdater = self
    }
    
    override func loadView() {
        super.loadView()
        
        self.setNavigationBar()
        view.addSubview(tableView)
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(BookCell.self, forCellReuseIdentifier: K.CellIds.bookCellId)
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
    
    func presentDetailView(of book: BookDetailViewModel) {
        let bookDetailViewController = BookDetailViewController()
        bookDetailViewController.overrideUserInterfaceStyle = .light
        
        bookDetailViewController.bookDetailViewModel = book
        
        present(bookDetailViewController, animated: true)
    }
    
    func searchBook() {
        let bookTitle = searchController.searchBar.text ?? ""
        self.bookmarkedBooksViewModel.searchBookmarkedBooks(bookTitle: bookTitle) { fetchedBooks in
            self.bookmarkedBooksViewModel.bookmarkedBooks = fetchedBooks
            self.tableView.reloadData()
        }
    }
}

extension BookmarkedBooksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = bookmarkedBooksViewModel.bookmarkedBooks[indexPath.row]
        let bookDetailViewModel = book.getDetailViewModelVersion()
        self.presentDetailView(of: bookDetailViewModel)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
}

extension BookmarkedBooksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookmarkedBooksViewModel.bookmarkedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIds.bookCellId, for: indexPath) as! BookCell
        let book = bookmarkedBooksViewModel.bookmarkedBooks[indexPath.row]
        cell.configure(book: book)
        
        cell.configureSubviews()
        cell.setupConstraints()
        
        cell.bookmarkButton.addAction(UIAction { _ in
            book.changeBookmarkedStatus()
            if book.isBookmarked {
                cell.bookmarkButton.setImage(UIImage(named: "Bookmarked Icon"), for: .normal)
            } else {
                cell.bookmarkButton.setImage(UIImage(named: "Bookmark Icon"), for: .normal)
            }
            print("\(book.title) is bookmarked == \(book.isBookmarked), na linha \(indexPath.row)")
        }, for: .touchUpInside)
        
        return cell
    }
}

extension BookmarkedBooksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchBook()
        
        if !searchController.isActive {
            self.bookmarkedBooksViewModel = BookmarkedBooksViewModel(authorization: self.authorization)
            tableView.reloadData()
        }
    }
    
    
}


