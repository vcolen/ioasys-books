//
//  BookDetailView.swift
//  ioasys books
//
//  Created by Victor Colen on 08/02/22.
//

import UIKit

class BookDetailView: UIView {
    
    let bookInfoNameArray = [
        "Páginas",
        "Editora",
        "Publicação",
        "Idioma",
        "Título Original",
        "ISBN-10",
        "ISBN-13"
    ]
    
    let bookInfoValueArray = [
        "304 Páginas",
        "Editora Loyola",
        "2020",
        "Inglês",
        "Change by Design",
        "0062856626",
        "978-0062856623"
    ]
    
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Detalhes"
        label.font = .heeboMedium(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var closeModalButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor(red: 0.67, green: 0.15, blue: 0.5, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Book")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var bookTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Change by Design Second line example"
        label.numberOfLines = 0
        label.font = .heeboMedium(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.text = "Tim Brown, Julie Zhuo, Fried Maximiilian"
        label.font = .heebo(ofSize: 14)
        label.textColor = UIColor(red: 0.67, green: 0.15, blue: 0.5, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bookInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Informacões".uppercased()
        label.font = .heeboMedium(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookInfoName: UILabel = {
        let label = UILabel()
        label.text = "Páginas"
        label.font = .heeboMedium(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookInfoValue: UILabel = {
        let label = UILabel()
        label.text = "304 páginas"
        label.font = .heebo(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookInfoVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 7
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bookInfoHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var reviewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var reviewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Resenha da Editora".uppercased()
        label.font = .heeboMedium(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var reviewDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        The subject of “design thinking” is the rage at business schools, throughout corporations, and increasingly in the popular press—due in large part to the work of IDEO, a leading design firm, and its celebrated CEO, Tim Brown, who uses this book to show how the techniques and strategies of design belong at every level of business.
"""
        label.font = .heebo(ofSize: 14)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubViews() {
        addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(detailLabel)
        mainStackView.addSubview(closeModalButton)
        mainStackView.addArrangedSubview(bookImage)
        mainStackView.addArrangedSubview(bookTitleStackView)
        bookTitleStackView.addArrangedSubview(bookTitleLabel)
        bookTitleStackView.addArrangedSubview(bookAuthorLabel)
        
        mainStackView.addArrangedSubview(bookInfoStackView)
        bookInfoStackView.addArrangedSubview(bookInfoTitleLabel)
        bookInfoStackView.addArrangedSubview(bookInfoVerticalStackView)
        
        for index in bookInfoNameArray.indices {
            let stackView = UIStackView()
            stackView.distribution = .equalSpacing
            stackView.axis = .horizontal
            bookInfoVerticalStackView.addArrangedSubview(stackView)
            
            let nameLabel = UILabel()
            nameLabel.text = bookInfoNameArray[index]
            nameLabel.font = .heeboMedium(ofSize: 14)
            stackView.addArrangedSubview(nameLabel)
            
            let valueLabel = UILabel()
            valueLabel.text = bookInfoValueArray[index]
            valueLabel.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
            valueLabel.font = .heebo(ofSize: 14)
            stackView.addArrangedSubview(valueLabel)
        }
        
        mainStackView.addArrangedSubview(reviewStackView)
        reviewStackView.addArrangedSubview(reviewTitleLabel)
        reviewStackView.addArrangedSubview(reviewDescriptionLabel)
    }
    
    func setupConstraints() {
        
        //Scroll View
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        //Main Stack View
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40),
            mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        //Book Image
        NSLayoutConstraint.activate([
            bookImage.widthAnchor.constraint(equalToConstant: 168),
            bookImage.heightAnchor.constraint(equalToConstant: 247)
        ])
        
        //Book Info Title Label
        NSLayoutConstraint.activate([
            bookInfoTitleLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor)
        ])
        
        
        //Book Info Vertical Stack View
        NSLayoutConstraint.activate([
            bookInfoVerticalStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            bookInfoVerticalStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
        ])
        
        //Close Modal Button
        NSLayoutConstraint.activate([
            closeModalButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            closeModalButton.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            closeModalButton.widthAnchor.constraint(equalToConstant: 14),
            closeModalButton.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
}
