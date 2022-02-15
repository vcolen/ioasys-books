//
//  LoginView.swift
//  ioasys books
//
//  Created by Victor Colen on 14/02/22.
//

import UIKit

class LoginView: UIView {
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Login Background")!)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor = UIColor(patternImage: UIImage(named: "Login Background")!)
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
    }
    
}
