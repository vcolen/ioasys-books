//
//  NavigationTitleView.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit

class NavigationTitleView: UIView {
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: K.Images.darkLogo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var booksTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Books"
        label.font = .heeboLight(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    lazy var navigationTitleMainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalCentering
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        addSubview(navigationTitleMainStackView)
        navigationTitleMainStackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(logoImageView)
        titleStackView.addArrangedSubview(booksTitleLabel)
        navigationTitleMainStackView.addArrangedSubview(logOutButton)
    }
    
    func setupConstraints() {
        
        //Navigation Title Main Stack View
        self.stretch(navigationTitleMainStackView)
        
        //Logo image
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 92.8),
            logoImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
