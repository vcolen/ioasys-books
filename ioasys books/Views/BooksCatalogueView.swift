//
//  BooksView.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit

class BooksCatalogueView: UIView {
    
    //MARK: - Upper layout
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.clipsToBounds = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var navigationTitleView = NavigationTitleView()
    var welcomeTitleView = WelcomeTitleView()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 50
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Book layout
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 50
        return stackView
    }()
    
    lazy var bookStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var searchBarTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Procure um livro"
        textField.borderStyle = .roundedRect
        textField.clearsOnBeginEditing = true
        textField.leftViewMode = .always
        textField.tintColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.shadowRadius = 24
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.09)
        textField.layer.shadowOpacity = 1.0
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        textField.leftView = imageView
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(navigationTitleView)
        titleStackView.addArrangedSubview(welcomeTitleView)
        mainStackView.addArrangedSubview(bookStackView)
        bookStackView.addArrangedSubview(searchBarTextField)
        
        for _ in 0..<12 {
            let view = BookContainerView()
            view.bookmarkButton.setImage(UIImage(systemName: Bool.random() ? "bookmark" : "bookmark.fill"), for: .normal)
            view.layer.cornerRadius = 4
            view.layer.shadowRadius = 24
            view.layer.shadowOffset = CGSize(width: 0, height: 4)
            view.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.09)
            view.layer.shadowOpacity = 1.0
            bookStackView.addArrangedSubview(view)
        }
    }
    
    func setupConstraints() {
        
        //Scroll View
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        //Main stack view
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        //Title stack view
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 24),
            titleStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            navigationTitleView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor, constant: -24)
        ])
        //Book stack view
        NSLayoutConstraint.activate([
            bookStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 24),
            bookStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchBarTextField.leadingAnchor.constraint(equalTo: bookStackView.leadingAnchor),
            searchBarTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        for view in bookStackView.arrangedSubviews[1...] {
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 160),
                view.widthAnchor.constraint(equalTo: bookStackView.widthAnchor)
            ])
        }
    }
}
