//
//  BookDetailViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 10/02/22.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    let customView = BookDetailView()
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func loadView() {
        super.loadView()
        
        
        loadBookDataInUI()
    }
    
    func loadBookDataInUI() {
        let view = BookDetailView()
        
        view.closeModalButton.addAction(UIAction {_ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        
        view.bookImage.sd_setImage(with: URL(string: book?.imageUrl ?? " "))
        view.mainStackView.addArrangedSubview(view.bookImage)
        
        view.mainStackView.addArrangedSubview(view.bookTitleStackView)
        
        view.bookTitleLabel.text = book?.title
        view.bookTitleStackView.addArrangedSubview(view.bookTitleLabel)
        
        view.bookAuthorLabel.text = book?.authors.joined(separator: ", ")
        view.bookTitleStackView.addArrangedSubview(view.bookAuthorLabel)
        
        
        view.mainStackView.addArrangedSubview(view.bookInfoStackView)
        view.bookInfoStackView.addArrangedSubview(view.bookInfoTitleLabel)
        view.bookInfoStackView.addArrangedSubview(view.bookInfoVerticalStackView)
        
        for index in view.bookInfoNameArray.indices {
            let stackView = UIStackView()
            stackView.distribution = .equalSpacing
            stackView.axis = .horizontal
            view.bookInfoVerticalStackView.addArrangedSubview(stackView)
            
            let nameLabel = UILabel()
            nameLabel.text = view.bookInfoNameArray[index]
            nameLabel.font = .heeboMedium(ofSize: 14)
            stackView.addArrangedSubview(nameLabel)
            
            let valueLabel = UILabel()
            valueLabel.text = view.bookInfoValueArray[index]
            valueLabel.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
            valueLabel.font = .heebo(ofSize: 14)
            stackView.addArrangedSubview(valueLabel)
        }
        
        view.mainStackView.addArrangedSubview(view.reviewStackView)
        
        view.reviewStackView.addArrangedSubview(view.reviewTitleLabel)
        
        view.reviewDescriptionLabel.text = book?.description
        view.reviewStackView.addArrangedSubview(view.reviewDescriptionLabel)
        
        //Book Image
        NSLayoutConstraint.activate([
            view.bookImage.widthAnchor.constraint(equalToConstant: 168),
            view.bookImage.heightAnchor.constraint(equalToConstant: 247)
        ])
        
        //Book Title Label
        
        NSLayoutConstraint.activate([
            view.bookTitleStackView.leadingAnchor.constraint(equalTo: view.mainStackView.leadingAnchor)
        ])
        
        //Book Info Title Label
        NSLayoutConstraint.activate([
            view.bookInfoTitleLabel.leadingAnchor.constraint(equalTo: view.mainStackView.leadingAnchor)
        ])
        
        //Book Info Vertical Stack View
        NSLayoutConstraint.activate([
            view.bookInfoVerticalStackView.leadingAnchor.constraint(equalTo: view.mainStackView.leadingAnchor),
            view.bookInfoVerticalStackView.trailingAnchor.constraint(equalTo: view.mainStackView.trailingAnchor),
        ])
        self.view = view
    }
}
