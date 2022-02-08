//
//  LoginFormView.swift
//  ioasys books
//
//  Created by Victor Colen on 08/02/22.
//

import UIKit

class LoginFormView: UIView {
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var emailInputView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordInputView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordInputStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Senha"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal) //other is "eye"
        button.tintColor = UIColor(red: 0.46, green: 0.46, blue: 0.47, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 28
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var formStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 68
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.22, green: 0.08, blue: 0.29, alpha: 1.0)
        button.setTitle("Entrar", for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        self.backgroundColor = .white
        addSubview(formStackView)
        formStackView.addArrangedSubview(inputStackView)
        inputStackView.addArrangedSubview(emailInputView)
        emailInputView.addSubview(emailTextField)
        inputStackView.addArrangedSubview(passwordInputView)
        passwordInputView.addSubview(passwordInputStackView)
        passwordInputStackView.addArrangedSubview(passwordTextField)
        passwordInputStackView.addArrangedSubview(showPasswordButton)
        formStackView.addArrangedSubview(loginButton)
    }
    
    
    //MARK: - Constraints
    
    func setupConstraints() {
        
        //Form Stack View
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: topAnchor, constant: 100), //Change this value when in final product
            formStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            formStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            formStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        //Input Stack View
        NSLayoutConstraint.activate([
            inputStackView.centerXAnchor.constraint(equalTo: formStackView.centerXAnchor)
        ])
        
        //Email Input View
        NSLayoutConstraint.activate([
            emailInputView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        //Email Text Field
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: emailInputView.leadingAnchor, constant: 16),
            emailTextField.topAnchor.constraint(equalTo: emailInputView.topAnchor, constant: 12),
            emailTextField.bottomAnchor.constraint(equalTo: emailInputView.bottomAnchor, constant: -12),
            emailTextField.trailingAnchor.constraint(equalTo: emailInputView.trailingAnchor, constant: -16)
        ])
        
        //Password Input View
        NSLayoutConstraint.activate([
            passwordInputView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        //Password Input Stack View
        NSLayoutConstraint.activate([
            passwordInputStackView.leadingAnchor.constraint(equalTo: passwordInputView.leadingAnchor, constant: 16),
            passwordInputStackView.topAnchor.constraint(equalTo: passwordInputView.topAnchor, constant: 12),
            passwordInputStackView.bottomAnchor.constraint(equalTo: passwordInputView.bottomAnchor, constant: -12),
            passwordInputStackView.trailingAnchor.constraint(equalTo: passwordInputView.trailingAnchor, constant: -16)
        ])
        
        //Login Button
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
