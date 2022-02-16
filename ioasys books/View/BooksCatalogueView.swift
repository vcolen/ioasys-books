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
        scrollView.backgroundColor = UIColor(red: 0.995, green: 0.995, blue: 0.995, alpha: 1.0) 
        scrollView.clipsToBounds = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var navigationTitleView = NavigationTitleView()
    lazy var pageDescriptionView = PageDescriptionView()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Book layout
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 32
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
    
    lazy var searchBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = 8
        stackView.layer.shadowRadius = 24
        stackView.layer.shadowOffset = CGSize(width: 4, height: 0)
        stackView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.09)
        stackView.layer.shadowOpacity = 1.0
        
        return stackView
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var searchBarTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Procure um livro"
        textField.clearsOnBeginEditing = true
        textField.backgroundColor = .clear
        
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
        titleStackView.addArrangedSubview(pageDescriptionView)
        mainStackView.addArrangedSubview(searchBarStackView)
        
        searchBarStackView.addArrangedSubview(searchButton)
        searchBarStackView.addArrangedSubview(searchBarTextField)
        
        mainStackView.addArrangedSubview(bookStackView)
    }
    
    func setupConstraints() {
        
        //Scroll View
        self.stretch(scrollView)
        
        //Main stack view
        self.stretch(mainStackView, to: scrollView)
        
        //Title Stack View
        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 24),
        ])
        
        //Search bar stack view
        NSLayoutConstraint.activate([
            searchBarStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 24),
            searchBarStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        //Search Button
        NSLayoutConstraint.activate([
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 30),
            searchButton.leadingAnchor.constraint(equalTo: searchBarStackView.leadingAnchor, constant: 13)
        ])
        
//        //Search bar Text Field
//        NSLayoutConstraint.activate([
//            searchBarTextField.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 24),
//            searchBarTextField.heightAnchor.constraint(equalToConstant: 40)
//        ])
        
        //Book Stack View
        NSLayoutConstraint.activate([
            bookStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 24),
            bookStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

