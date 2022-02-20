//
//  LoginView.swift
//  ioasys books
//
//  Created by Victor Colen on 14/02/22.
//

import UIKit

class LoginView: UIView {
        
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addBackground(imageName: K.Images.loginBackgroundImage)
        stackView.accessibilityIdentifier = "LoginView.mainStackView"
        return stackView
    }()
    
    lazy var logoView = MainLogoView()
    lazy var loginFormView = LoginFormView()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(logoView)
        mainStackView.addArrangedSubview(loginFormView)
        
        loginFormView.layer.cornerRadius = 16
    }
    
    func setupConstraints() {
        //Main Stack View
        self.stretch(mainStackView)
        
        NSLayoutConstraint.activate([
            loginFormView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/2.4)
        ])
    }
    
}
