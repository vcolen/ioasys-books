//
//  LoginFormView.swift
//  ioasys books
//
//  Created by Victor Colen on 08/02/22.
//

import UIKit

class LoginFormView: UIView {
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Logo VIew
    lazy var logoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .blue
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var booksLabel: UILabel = {
        let label = UILabel()
        label.text = "Books"
        label.font = .heeboLight(ofSize: 32)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Login Form View
    lazy var formStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 68
        stackView.accessibilityIdentifier = "form stack view"
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.accessibilityIdentifier = "inputStackView"
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var emailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.accessibilityIdentifier = "email stack view"
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = .robotoMedium(ofSize: 12)
        label.textColor = .clear
        label.accessibilityIdentifier = "emailLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailInputView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "emailInputView"
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.font = .roboto(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = "emailTextField"
        return textField
    }()
    
    lazy var failLoginLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMedium(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Senha"
        label.font = .robotoMedium(ofSize: 12)
        label.textColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        textField.font = .roboto(ofSize: 16)
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
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.22, green: 0.08, blue: 0.29, alpha: 1.0)
        button.setTitle("E N T R A R", for: .normal)
        button.titleLabel?.font = .heeboMedium(ofSize: 14)
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
        
        inputStackView.addArrangedSubview(emailStackView)
        
        emailStackView.addArrangedSubview(emailLabel)
        emailStackView.addArrangedSubview(emailInputView)
        
        emailInputView.addSubview(emailTextField)
        
        emailStackView.addArrangedSubview(failLoginLabel)
        inputStackView.addArrangedSubview(passwordStackView)
        
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordInputView)
        
        passwordInputView.addSubview(passwordInputStackView)
        
        passwordInputStackView.addArrangedSubview(passwordTextField)
        passwordInputStackView.addArrangedSubview(showPasswordButton)
        
        formStackView.addArrangedSubview(loginButton)
    }
    
    
    //MARK: - Constraints
    
    func setupConstraints() {
        
        //Form Stack View
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            formStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            formStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
        
        //Input Stack View
        NSLayoutConstraint.activate([
            inputStackView.topAnchor.constraint(equalTo: formStackView.topAnchor),
            inputStackView.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),
            inputStackView.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor)
        ])
        
        //MARK: - Email Constraints
        
        //Email stack view
        NSLayoutConstraint.activate([
            emailStackView.leadingAnchor.constraint(equalTo: inputStackView.leadingAnchor),
            emailStackView.trailingAnchor.constraint(equalTo: inputStackView.trailingAnchor)
        ])
        
        //Email Label
        NSLayoutConstraint.activate([
            emailLabel.leadingAnchor.constraint(equalTo: emailStackView.leadingAnchor, constant: 16)
        ])
        
        //Email Input View
        NSLayoutConstraint.activate([
            emailInputView.heightAnchor.constraint(equalToConstant: 48),
            emailInputView.leadingAnchor.constraint(equalTo: emailStackView.leadingAnchor)
        ])
        
        //Email Text Field
        self.stretch(emailTextField, to: emailInputView, top: 12, left: 16, bottom: -16, right: -12)
        
        
        //Fail Login Label
        NSLayoutConstraint.activate([
            failLoginLabel.leadingAnchor.constraint(equalTo: emailStackView.leadingAnchor, constant: 21)
        ])
        
        //MARK: - Password Constraints
        
        NSLayoutConstraint.activate([
            passwordStackView.leadingAnchor.constraint(equalTo: inputStackView.leadingAnchor)
        ])
        
        //Password Label
        NSLayoutConstraint.activate([
            passwordLabel.leadingAnchor.constraint(equalTo: passwordStackView.leadingAnchor, constant: 16)
        ])
        
        //Password Input View
        NSLayoutConstraint.activate([
            passwordInputView.heightAnchor.constraint(equalToConstant: 48),
            passwordInputView.leadingAnchor.constraint(equalTo: passwordStackView.leadingAnchor)
        ])
        
        //Password Input Stack View
        self.stretch(passwordInputStackView, to: passwordInputView, top: 12, left: 16, bottom: -12, right: -16)
        
        //Login Button
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
