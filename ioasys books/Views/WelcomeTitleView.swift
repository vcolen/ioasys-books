//
//  WelcomeTitleView.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit

class WelcomeTitleView: UIView {
    
    lazy var welcomeLabel: UILabel = {
        let l = UILabel()
        l.text = "Bem vindo, "
        l.font = .heebo(ofSize: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
       return l
    }()
    
    lazy var userNameLabel: UILabel = {
       let l = UILabel()
        l.text = "Guilherme!"
        l.font = .heeboMedium(ofSize: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var mainStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func configureSubviews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(welcomeLabel)
        mainStackView.addArrangedSubview(userNameLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        //Main Stack View
        NSLayoutConstraint.activate([
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
}
