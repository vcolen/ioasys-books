//
//  NavigationTitleView.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit

class NavigationTitleView: UIView {
    
    lazy var ioasysTitleLabel: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "ioasys"
        l.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return l
    }()
    
    lazy var booksTitleLabel: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Books"
        l.font = UIFont.systemFont(ofSize: 30, weight: .thin)
        return l
    }()
    
    lazy var titleStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 12.2
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        addSubview(titleStackView)
        titleStackView.addArrangedSubview(ioasysTitleLabel)
        titleStackView.addArrangedSubview(booksTitleLabel)
    }
    
}
