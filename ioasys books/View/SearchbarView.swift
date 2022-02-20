//
//  SearchbarView.swift
//  ioasys books
//
//  Created by Victor Colen on 16/02/22.
//

import UIKit

class SearchbarView: UIView {
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
        stackView.accessibilityIdentifier = "SearchbarView.searchBarStackView"
        
        return stackView
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "SearchbarView.searchButton"
        
        return button
    }()
    
    lazy var searchBarTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Procure um livro"
        textField.clearsOnBeginEditing = true
        textField.backgroundColor = .clear
        textField.accessibilityIdentifier = "SearchbarView.searchBarTextField"
        
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
        addSubview(searchBarStackView)
        searchBarStackView.addArrangedSubview(searchButton)
        searchBarStackView.addArrangedSubview(searchBarTextField)
    }
    
    func setupConstraints() {
        //Search bar stack view
        self.stretch(searchBarStackView)
        NSLayoutConstraint.activate([
            searchBarStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        //Search Button
        NSLayoutConstraint.activate([
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 30),
            searchButton.leadingAnchor.constraint(equalTo: searchBarStackView.leadingAnchor, constant: 13)
        ])
    }
}
