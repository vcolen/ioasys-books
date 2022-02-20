//
//  SearchbarView.swift
//  ioasys books
//
//  Created by Victor Colen on 16/02/22.
//

import UIKit

class SearchbarView: UIView {
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.shadowRadius = 24
        view.layer.shadowOffset = CGSize(width: 4, height: 0)
        view.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.09)
        view.layer.shadowOpacity = 1.0
        view.accessibilityIdentifier = "SearchbarView.mainView"
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var searchBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.spacing = 13
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
        textField.autocorrectionType = .no
        
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
        addSubview(mainView)
        mainView.addSubview(searchBarStackView)
        searchBarStackView.addArrangedSubview(searchButton)
        searchBarStackView.addArrangedSubview(searchBarTextField)
    }
    
    func setupConstraints() {
        
        //Main View
        self.stretch(mainView)
        NSLayoutConstraint.activate([
            mainView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        //Search bar stack view
        self.stretch(searchBarStackView, to: mainView, left: 16, right: -16)
        
        //Search Button
        NSLayoutConstraint.activate([
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.centerYAnchor.constraint(equalTo: searchBarStackView.centerYAnchor)
        ])
        
        //Search bar Text Field
        NSLayoutConstraint.activate([
            searchBarTextField.centerYAnchor.constraint(equalTo: searchBarStackView.centerYAnchor)
        ])
    }
}
