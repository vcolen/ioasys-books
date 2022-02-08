//
//  BookContainerView.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit

class BookContainerView: UIView {
    
    lazy var bookContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bookCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Book 1")
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = .magenta
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var bookFullInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        //stackView.backgroundColor = .green
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bookPrimaryInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        //  stackView.backgroundColor = .red
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bookTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Crossing the Chasm"
        l.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        l.numberOfLines = 2
        l.lineBreakMode = .byWordWrapping
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var bookAuthorLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(red:0.67, green: 0.15, blue: 0.5, alpha: 1.0)
        l.text = "Geoffrey A. Moore"
        l.numberOfLines = 2
        l.font = UIFont.systemFont(ofSize: 14)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var bookSecondaryInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        // stackView.backgroundColor = .blue
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bookPageCountLabel: UILabel = {
        let l = UILabel()
        l.text = "150 páginas"
        l.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        l.font = UIFont.systemFont(ofSize: 12)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var bookPublisherLabel: UILabel = {
        let l = UILabel()
        l.text = "Editora Loyola"
        l.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        l.font = UIFont.systemFont(ofSize: 12)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var bookPublishedLabel: UILabel = {
        let l = UILabel()
        l.text = "Publicado em 2020"
        l.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        l.font = UIFont.systemFont(ofSize: 12)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
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
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        addSubview(bookContainerStackView)
        bookContainerStackView.addArrangedSubview(bookCoverImageView)
        bookContainerStackView.addArrangedSubview(bookFullInfoStackView)
        bookFullInfoStackView.addArrangedSubview(bookPrimaryInfoStackView)
        bookPrimaryInfoStackView.addArrangedSubview(bookTitleLabel)
        bookPrimaryInfoStackView.addArrangedSubview(bookAuthorLabel)
        bookFullInfoStackView.addArrangedSubview(bookSecondaryInfoStackView)
        bookSecondaryInfoStackView.addArrangedSubview(bookPageCountLabel)
        bookSecondaryInfoStackView.addArrangedSubview(bookPublisherLabel)
        bookSecondaryInfoStackView.addArrangedSubview(bookPublishedLabel)
        bookContainerStackView.addArrangedSubview(bookmarkButtonView)
        bookmarkButtonView.addSubview(bookmarkButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            bookContainerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bookContainerStackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            //bookCoverImageView.leadingAnchor.constraint(equalTo: bookContainerStackView.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            bookFullInfoStackView.topAnchor.constraint(equalTo: bookContainerStackView.topAnchor, constant: 16),
            bookFullInfoStackView.bottomAnchor.constraint(equalTo: bookContainerStackView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            bookFullInfoStackView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: bookmarkButtonView.topAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: bookmarkButtonView.trailingAnchor, constant: -21)
        ])
    }
    
}
