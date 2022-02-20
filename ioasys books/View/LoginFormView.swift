//
//  LoginFormView.swift
//  ioasys books
//
//  Created by Victor Colen on 08/02/22.
//

import UIKit

class LoginFormView: UIView {
    
    lazy var formStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = UIScreen.main.bounds.height/17
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "LoginFormView.formStackView"
        
        return stackView
    }()
    
    lazy var inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "LoginFormView.inputStackView"
        
        return stackView
    }()
    
    lazy var emailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "LoginFormView.emailStackView"
        
        return stackView
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = .robotoMedium(ofSize: 12)
        label.textColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "LoginFormView.emailLabel"
        
        return label
    }()
    
    lazy var emailInputView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "LoginFormView.emailInputView"
        
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.26,
                                                                         green: 0.27,
                                                                         blue: 0.28,
                                                                         alpha: 1.0)]
        )
        textField.font = .roboto(ofSize: 16)
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = "LoginFormView.emailTextField"
        
        return textField
    }()
    
    lazy var problematicEmailLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMedium(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "LoginFormView.incorrectEmailLabel"
        
        return label
    }()
    
    lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "LoginFormView.passwordStackView"
        
        return stackView
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Senha"
        label.font = .robotoMedium(ofSize: 12)
        label.textColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "LoginFormView.passwordLabel"
        
        return label
    }()
    
    lazy var passwordInputView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "LoginFormView.passwordInputView"
        
        return view
    }()
    
    lazy var passwordInputStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.accessibilityIdentifier = "LoginFormView.passwordInputStackView"
        
        return stackview
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Senha",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.26,
                                                                         green: 0.27,
                                                                         blue: 0.28,
                                                                         alpha: 1.0)
                        ]
        )
        textField.font = .roboto(ofSize: 16)
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = "LoginFormView.passwordTextField"
        
        return textField
    }()
    
    lazy var problematicPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMedium(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "LoginFormView.problematicPasswordLabel"
        
        return label
    }()
    
    lazy var changePasswordVisibility: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = UIColor(red: 0.46, green: 0.46, blue: 0.47, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "LoginFormView.changePasswordVisibility"
        
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.22, green: 0.08, blue: 0.29, alpha: 1.0)
        button.setTitle("E N T R A R", for: .normal)
        button.titleLabel?.font = .heeboMedium(ofSize: 14)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "LoginFormView.loginButton"
        
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
        emailStackView.addArrangedSubview(problematicEmailLabel)
        inputStackView.addArrangedSubview(passwordStackView)
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordInputView)
        passwordInputView.addSubview(passwordInputStackView)
        passwordInputStackView.addArrangedSubview(passwordTextField)
        passwordInputStackView.addArrangedSubview(changePasswordVisibility)
        passwordStackView.addArrangedSubview(problematicPasswordLabel)
        formStackView.addArrangedSubview(loginButton)
    }
    
    
    //MARK: - Constraints
    
    func setupConstraints() {
        
        //Form Stack View
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            formStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            formStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            formStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10)
        ])
        
        //Input Stack View
        NSLayoutConstraint.activate([
            inputStackView.topAnchor.constraint(equalTo: formStackView.topAnchor),
            inputStackView.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),
            inputStackView.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor)
        ])
        
        //MARK: - Email Constraints
        
        //Email Stack View
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
        self.stretch(emailTextField, to: emailInputView, left: 16, right: -16)
        
        
        //Incorrect Email Label
        NSLayoutConstraint.activate([
            problematicEmailLabel.leadingAnchor.constraint(equalTo: emailStackView.leadingAnchor, constant: 21)
        ])
        
        //MARK: - Password Constraints
        
        //Password Stack View
        NSLayoutConstraint.activate([
            passwordStackView.leadingAnchor.constraint(equalTo: inputStackView.leadingAnchor),
            passwordStackView.trailingAnchor.constraint(equalTo: inputStackView.trailingAnchor)
        ])
        
        //Password Label
        NSLayoutConstraint.activate([
            passwordLabel.leadingAnchor.constraint(equalTo: passwordStackView.leadingAnchor, constant: 16)
        ])
        
        //Password Input View
        NSLayoutConstraint.activate([
            passwordInputView.heightAnchor.constraint(equalTo: emailInputView.heightAnchor),
            passwordInputView.leadingAnchor.constraint(equalTo: passwordStackView.leadingAnchor)
        ])
        
        //Password Input Stack View
        self.stretch(passwordInputStackView, to: passwordInputView, left: 16, right: -16)
        
        //Problematic Password Label
        NSLayoutConstraint.activate([
            problematicPasswordLabel.leadingAnchor.constraint(equalTo: passwordStackView.leadingAnchor, constant: 21)
        ])
        
        //Change password Visibility Button
        NSLayoutConstraint.activate([
            changePasswordVisibility.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        //MARK: - Login
        
        //Login Button
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(greaterThanOrEqualTo: emailInputView.heightAnchor),
            loginButton.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor)
        ])
    }
}
