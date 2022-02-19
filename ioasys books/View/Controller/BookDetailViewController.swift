//
//  BookDetailViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 10/02/22.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    let customView = BookDetailView()
    var viewModel: BookDetailViewModel! {
        didSet {
            loadBookDataInUI()
        }
    }
    
    func loadBookDataInUI() {
        let view = BookDetailView()
        
        view.closeModalButton.addAction(UIAction {_ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        
        view.bookImage.sd_setImage(with: viewModel.coverImageUrl)
        view.mainStackView.addArrangedSubview(view.bookImage)
        
        view.mainStackView.addArrangedSubview(view.bookTitleStackView)
        
        view.bookTitleLabel.text = viewModel.title
        view.bookTitleStackView.addArrangedSubview(view.bookTitleLabel)
        
        view.bookAuthorLabel.text = viewModel.authors
        view.bookTitleStackView.addArrangedSubview(view.bookAuthorLabel)
        
        view.mainStackView.addArrangedSubview(view.bookInfoStackView)
        view.bookInfoStackView.addArrangedSubview(view.bookInfoTitleLabel)
        
        let bookInfoTable = BookTableInfoView()
        
        view.bookInfoStackView.addArrangedSubview(bookInfoTable.bookInfoVerticalStackView)
        
        
        for info in viewModel.info {
            let stackView = UIStackView()
            stackView.distribution = .equalSpacing
            stackView.axis = .horizontal
            bookInfoTable.bookInfoVerticalStackView.addArrangedSubview(stackView)
            
            let nameLabel = UILabel()
            nameLabel.text = info.key
            nameLabel.font = .heeboMedium(ofSize: 14)
            stackView.addArrangedSubview(nameLabel)
            
            let valueLabel = UILabel()
            valueLabel.text = info.value
            valueLabel.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
            valueLabel.font = .heebo(ofSize: 14)
            stackView.addArrangedSubview(valueLabel)
        }
        
        view.mainStackView.addArrangedSubview(view.reviewStackView)
        
        view.reviewStackView.addArrangedSubview(view.reviewTitleLabel)
        
        view.reviewDescriptionLabel.text = viewModel.review
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
            bookInfoTable.bookInfoVerticalStackView.leadingAnchor.constraint(equalTo: view.mainStackView.leadingAnchor),
            bookInfoTable.bookInfoVerticalStackView.trailingAnchor.constraint(equalTo: view.mainStackView.trailingAnchor),
        ])
        
        self.view = view
    }
}
