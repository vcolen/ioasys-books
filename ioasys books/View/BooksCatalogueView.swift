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
    
    lazy var searchbarView = SearchbarView()
    
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
        mainStackView.addArrangedSubview(searchbarView)
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
            searchbarView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 24),
            searchbarView.heightAnchor.constraint(equalToConstant: 40)
        ])
                
        //Book Stack View
        NSLayoutConstraint.activate([
            bookStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 24),
            bookStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

