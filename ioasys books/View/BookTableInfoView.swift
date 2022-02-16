//
//  BookInfoTableView.swift
//  ioasys books
//
//  Created by Victor Colen on 15/02/22.
//

import UIKit

class BookTableInfoView: UIView {
    
    lazy var bookInfoName: UILabel = {
        let label = UILabel()
        label.font = .heeboMedium(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookInfoValue: UILabel = {
        let label = UILabel()
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
}
