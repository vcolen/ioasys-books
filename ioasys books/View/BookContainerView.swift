//
//  BookContainerView.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit

class BookContainerView: UIView {
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "mainView"
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "mainStackView"
        return stackView
    }()
    
    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "coverImageView"
        return imageView
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "infoStackView"
        return stackView
    }()
    
    lazy var titleAndAuthorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "titleAndAuthorStackView"
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .heeboMedium(ofSize: 16)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "titleLabel"
        return label
    }()
    
    lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.67, green: 0.15, blue: 0.5, alpha: 1.0)
        label.numberOfLines = 1
        label.font = .heebo(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "authorNameLabel"
        return label
    }()
    
    lazy var secondaryInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "secondaryInfoStackView"
        return stackView
    }()
    
    lazy var bookmarkButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red:0.67, green: 0.15, blue: 0.5, alpha: 1.0)
        button.setImage(UIImage(named: "Bookmark Icon"), for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "bookmarkButton"
        return button
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
        mainView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(coverImageView)
        mainStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(titleAndAuthorStackView)
        titleAndAuthorStackView.addArrangedSubview(titleLabel)
        titleAndAuthorStackView.addArrangedSubview(authorNameLabel)
        infoStackView.addArrangedSubview(secondaryInfoStackView)
        mainStackView.addArrangedSubview(bookmarkButtonView)
        bookmarkButtonView.addSubview(bookmarkButton)
    }
    
    func setupConstraints() {
        
        //Main View
        self.stretch(mainView)
        
        //Container Stack View
        NSLayoutConstraint.activate([
            mainStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -22.78),
            mainStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            mainStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16)
        ])
        
        //Cover Image View
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            coverImageView.widthAnchor.constraint(equalToConstant: 81),
            coverImageView.heightAnchor.constraint(equalToConstant: 123)
        ])
        
        //Info Stack View
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
        ])
        
        //Bookmark Button View
        NSLayoutConstraint.activate([
            bookmarkButtonView.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        //Bookmark Button
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: bookmarkButtonView.topAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: bookmarkButtonView.trailingAnchor)
        ])
    }
}
