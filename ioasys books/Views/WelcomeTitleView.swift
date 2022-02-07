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
        l.translatesAutoresizingMaskIntoConstraints = false
       return l
    }()
    
    lazy var userNameLabel: UILabel = {
       let l = UILabel()
        l.text = "Guilherme!"
        l.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func configureSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(welcomeLabel)
        stackView.addArrangedSubview(userNameLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
