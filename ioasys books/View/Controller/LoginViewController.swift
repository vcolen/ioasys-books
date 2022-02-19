//
//  LoginViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 08/02/22.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

class LoginViewController: UIViewController {
    
    lazy var customView = LoginView()
    //var activityIndicatorView = ActivityIndicatorView()
    var loginViewModel: LoginViewModel!
    var spinnerViewController = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        customView.loginFormView.loginButton.isEnabled = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        customView.loginFormView.emailTextField.delegate = self
        customView.loginFormView.passwordTextField.delegate = self
        self.customView.setOnClickListener {
            self.view.endEditing(true)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = customView
        setupView()
        setupTextFields()
    }
    
    
    
    func createSpinnerView() {
        // add the spinner view controller
        addChild(spinnerViewController)
        spinnerViewController.view.frame = view.frame
        view.addSubview(spinnerViewController.view)
        spinnerViewController.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customView.loginFormView.loginButton.addAction(UIAction { [weak self] _ in
            self?.view.endEditing(true)
            UIView.animate(withDuration: 0.25) {
                self?.customView.loginFormView.loginButton.backgroundColor = .buttonPurple
                self?.customView.loginFormView.loginButton.backgroundColor = .buttonPressedPurple
            }
            self?.didTapLogin()
        }, for: .touchUpInside)
        self.loginViewModel = LoginViewModel()
    }
    
    func navigateToCatalogue(user: UserViewModel, authorization: String) {
        let tabBarViewController = MainTabBarViewController()
        tabBarViewController.userViewModel = user
        tabBarViewController.authorization = authorization
        
        stopSpinning()
        navigationController?.setViewControllers([tabBarViewController], animated: true)
    }
    
    func askToFillEmailTextField(withMessage message: String) {
        customView.loginFormView.emailLabel.textColor = .errorRed
        customView.loginFormView.emailInputView.layer.borderColor = .errorRed
        customView.loginFormView.emailTextField.textColor = .errorRed
        
        customView.loginFormView.problematicEmailLabel.textColor = .errorRed
        customView.loginFormView.problematicEmailLabel.text = message
    }
    
    func askToFillPasswordTextField(withMessage message: String) {
        customView.loginFormView.problematicEmailLabel.textColor = .clear
        customView.loginFormView.problematicEmailLabel.text = ""
        
        customView.loginFormView.passwordLabel.textColor = .errorRed
        customView.loginFormView.passwordInputView.layer.borderColor = .errorRed
        customView.loginFormView.passwordTextField.textColor = .errorRed
        customView.loginFormView.problematicPasswordLabel.textColor = .errorRed
        
        customView.loginFormView.problematicPasswordLabel.text = message
    }
    
    func stopSpinning() {
        // then remove the spinner view controller
        spinnerViewController.willMove(toParent: nil)
        spinnerViewController.view.removeFromSuperview()
        spinnerViewController.removeFromParent()
    }
    
    func didTapLogin() {
        guard customView.loginFormView.emailTextField.text != "" else {
            askToFillEmailTextField(withMessage: "Por favor, preencha o campo do email.")
            return
        }
        
        guard customView.loginFormView.passwordTextField.text != ""  else {
            askToFillPasswordTextField(withMessage: "Por favor, preencha o campo da senha.")
            return
        }
        
        //Preventing user from making multiple API requests
        customView.loginFormView.loginButton.isEnabled = false
        
        let email = customView.loginFormView.emailTextField.text!
        let password = customView.loginFormView.passwordTextField.text!
        
        createSpinnerView()
        loginViewModel.loginUser(email: email, password: password) { user, authorization, error in
            guard let user = user else {
                self.didFailLogin()
                self.stopSpinning()
                return
            }
            
            guard let authorization = authorization else {
                self.didFailLogin()
                self.stopSpinning()
                return
            }

            DispatchQueue.main.async {
                self.navigateToCatalogue(user: user, authorization: authorization)
            }
        }
    }
    
    func didFailLogin() {
        customView.loginFormView.loginButton.isEnabled = true
        askToFillEmailTextField(withMessage: "Email ou senha incorretos.")
        customView.loginFormView.problematicPasswordLabel.text = ""
    }
    
    func setupView() {
        self.customView.loginFormView.changePasswordVisibility.addAction(UIAction {_ in
            self.changePasswordVisibility()
        }, for: .touchUpInside)
    }
    
    func changePasswordVisibility() {
        self.customView.loginFormView.passwordTextField.isSecureTextEntry.toggle()
        
        if self.customView.loginFormView.passwordTextField.isSecureTextEntry {
            self.customView.loginFormView.changePasswordVisibility.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            self.customView.loginFormView.changePasswordVisibility.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    func setupTextFields() {
        
        //Email
        customView.loginFormView.emailTextField.addAction(UIAction {  _ in
            if self.customView.loginFormView.emailTextField.hasText {
                self.showLabel(label: self.customView.loginFormView.emailLabel, color: .black, text: "Email")
            } else {
                self.hideLabel(label: self.customView.loginFormView.emailLabel)
            }
        }, for: .editingChanged)
        
        //Password
        customView.loginFormView.passwordTextField.addAction(UIAction {  _ in
            if self.customView.loginFormView.passwordTextField.hasText {
                self.showLabel(label: self.customView.loginFormView.passwordLabel, color: .black, text: "Senha")
            } else {
                self.hideLabel(label: self.customView.loginFormView.passwordLabel)
            }
        }, for: .editingChanged)
    }
    
    func hideLabel(label: UILabel) {
        label.textColor = .clear
    }
    
    func showLabel(label: UILabel, color: UIColor, text: String) {
        label.textColor = .black
    }
    
    func moveTextField(_ textField: UITextField, distance: CGFloat, up: Bool) {
        let movement = CGFloat(up ? -distance : distance)
        
        UIView.animate(withDuration: 0.3) {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, distance: customView.loginFormView.formStackView.bounds.height, up: true)
        if textField == customView.loginFormView.emailTextField {
        customView.loginFormView.emailInputView.layer.borderColor = .black
        } else {
            customView.loginFormView.passwordInputView.layer.borderColor = .black
        }
        textField.textColor = .black
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, distance: customView.loginFormView.formStackView.bounds.height, up: false)
        customView.loginFormView.emailInputView.layer.borderColor = .grayish
    }
}
