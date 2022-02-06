//
//  BooksView.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit

class BooksView: UIView {
    
    //MARK: - Upper layout
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .green
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
        stackView.backgroundColor = .yellow
        return stackView
    }()
    
    lazy var bookStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.backgroundColor = .red
        return stackView
    }()
    
    lazy var searchBarTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Procure um livro"
        textField.borderStyle = .roundedRect
        textField.clearsOnBeginEditing = true
        textField.leftViewMode = .always
        textField.textColor = .black
        
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
        
        for _ in 0..<10 {
          let view = UIView()
          view.backgroundColor = .blue
            view.layer.cornerRadius = 4
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
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        //Title stack view
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 24),
            titleStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 24),
        ])
        
        //Navigation Title view
        NSLayoutConstraint.activate([
            navigationTitleView.topAnchor.constraint(equalTo: titleStackView.topAnchor),
            navigationTitleView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            navigationTitleView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
        ])
        
        //Welcome title view
        NSLayoutConstraint.activate([
            welcomeTitleView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            welcomeTitleView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
        ])
        
        //Book stack view
        NSLayoutConstraint.activate([
            bookStackView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            bookStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 24),
            bookStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 24),
            bookStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchBarTextField.leadingAnchor.constraint(equalTo: bookStackView.leadingAnchor),
            searchBarTextField.trailingAnchor.constraint(equalTo: bookStackView.trailingAnchor)
        ])
        
        for view in bookStackView.arrangedSubviews[1...] {
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 160),
                view.widthAnchor.constraint(equalTo: bookStackView.widthAnchor)
            ])
          }
    }
}
