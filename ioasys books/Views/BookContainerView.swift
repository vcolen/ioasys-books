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
        return view
    }()
    
    lazy var bookContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bookCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Book 1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var bookFullInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bookTitleAndAuthorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Crossing the Chasm"
        label.font = .heeboMedium(ofSize: 16)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.67, green: 0.15, blue: 0.5, alpha: 1.0)
        label.text = "Geoffrey A. Moore"
        label.numberOfLines = 1
        label.font = .heebo(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookSecondaryInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bookPageCountLabel: UILabel = {
        let label = UILabel()
        label.text = "150 páginas"
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        label.font = .heebo(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookPublisherLabel: UILabel = {
        let label = UILabel()
        label.text = "Editora Loyola"
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookPublishedLabel: UILabel = {
        let label = UILabel()
        label.text = "Publicado em 2020"
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        mainView.addSubview(bookContainerStackView)
        bookContainerStackView.addArrangedSubview(bookCoverImageView)
        bookContainerStackView.addArrangedSubview(bookFullInfoStackView)
        bookFullInfoStackView.addArrangedSubview(bookTitleAndAuthorStackView)
        bookTitleAndAuthorStackView.addArrangedSubview(bookTitleLabel)
        bookTitleAndAuthorStackView.addArrangedSubview(bookAuthorLabel)
        bookFullInfoStackView.addArrangedSubview(bookSecondaryInfoStackView)
        bookSecondaryInfoStackView.addArrangedSubview(bookPageCountLabel)
        bookSecondaryInfoStackView.addArrangedSubview(bookPublisherLabel)
        bookSecondaryInfoStackView.addArrangedSubview(bookPublishedLabel)
        bookContainerStackView.addArrangedSubview(bookmarkButtonView)
        bookmarkButtonView.addSubview(bookmarkButton)
    }
    
    func setupConstraints() {
        
        //Main View
        self.stretch(mainView)
        
        //Book Container Stack View
        NSLayoutConstraint.activate([
            bookContainerStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -22.78),
            bookContainerStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            bookContainerStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16)
        ])
        
        //Book Cover Image View
        NSLayoutConstraint.activate([
            bookCoverImageView.leadingAnchor.constraint(equalTo: bookContainerStackView.leadingAnchor),
            bookCoverImageView.widthAnchor.constraint(equalToConstant: 81),
            bookCoverImageView.heightAnchor.constraint(equalToConstant: 123)
        ])
        
        //Book Full Info Stack View
        NSLayoutConstraint.activate([
            bookFullInfoStackView.topAnchor.constraint(equalTo: bookContainerStackView.topAnchor),
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
