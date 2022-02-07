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
    
    lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Log Out Icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titleStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 12.2
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    lazy var navigationTitleMainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 138
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
        addSubview(navigationTitleMainStackView)
        navigationTitleMainStackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(ioasysTitleLabel)
        titleStackView.addArrangedSubview(booksTitleLabel)
        navigationTitleMainStackView.addArrangedSubview(logOutButton)
    }
}
