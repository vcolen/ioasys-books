//
//  Cell.swift
//  Todoey
//
//  Created by Victor Colen on 22/02/22.
//

import UIKit

class BookCell: UITableViewCell {
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "BookContainerView.mainView"
        
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "BookContainerView.mainStackView"
        
        return stackView
    }()
    
    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "BookContainerView.coverImageView"
        
        return imageView
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "BookContainerView.infoStackView"
        
        return stackView
    }()
    
    lazy var titleAndAuthorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "BookContainerView.titleAndAuthorStackView"
        
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .heeboMedium(ofSize: 16)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "BookContainerView.titleLabel"
        
        return label
    }()
    
    lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.67, green: 0.15, blue: 0.5, alpha: 1.0)
        label.numberOfLines = 1
        label.font = .heebo(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "BookContainerView.authorNameLabel"
        
        return label
    }()
    
    lazy var secondaryInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "BookContainerView.secondaryInfoStackView"
        
        return stackView
    }()
    
    lazy var bookmarkButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "BookContainerView.bookmarkButtonView"
        
        return view
    }()
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red:0.67, green: 0.15, blue: 0.5, alpha: 1.0)
        button.setImage(UIImage(named: K.Images.isNotBookmarked), for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "BookContainerView.bookmarkButton"
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    func configure(book: BookViewModel) {
        coverImageView.sd_setImage(with: book.coverImageUrl)
        titleLabel.text = book.title
        authorNameLabel.text = book.authors
        bookmarkButton.setImage(UIImage(
            named: book.isBookmarked ? K.Images.isBookmarked : K.Images.isNotBookmarked
        ), for: .normal)
        
        secondaryInfoStackView.removeFullyAllArrangedSubviews()
        
        for info in book.info {
            let infoLabel = UILabel()
            infoLabel.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
            infoLabel.font = .heebo(ofSize: 12)
            infoLabel.text = info
            
            secondaryInfoStackView.addArrangedSubview(infoLabel)
        }
        
        bookmarkButton.addAction(UIAction { _ in
            book.changeBookmarkedStatus()
            if book.isBookmarked {
                self.bookmarkButton.setImage(UIImage(named: "Bookmarked Icon"), for: .normal)
            } else {
                self.bookmarkButton.setImage(UIImage(named: "Bookmark Icon"), for: .normal)
            }
        }, for: .touchUpInside)
        
//        layer.cornerRadius = 4
//        layer.shadowRadius = 24
//        layer.shadowOffset = CGSize(width: 0, height: 4)
//        layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.09)
//        layer.shadowOpacity = 1.0

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
