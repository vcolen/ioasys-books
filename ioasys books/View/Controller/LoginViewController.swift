//
//  LoginViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 08/02/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var viewCustom = LoginView()
    var userViewModel: UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        overrideUserInterfaceStyle = .dark
        viewCustom.loginFormView.loginButton.isEnabled = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func loadView() {
        super.loadView()
        
        view = viewCustom
        setupView()
        setupTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        viewCustom.loginFormView.loginButton.addAction(UIAction { [weak self] _ in
            UIView.animate(withDuration: 0.25) {
                self?.viewCustom.loginFormView.loginButton.backgroundColor = UIColor(red: 0.11,
                                                                                     green: 0.03,
                                                                                     blue: 0.20,
                                                                                     alpha: 1.0)
                self?.viewCustom.loginFormView.loginButton.backgroundColor = UIColor(red: 0.22,
                                                                                     green: 0.08,
                                                                                     blue: 0.29,
                                                                                     alpha: 1.0)
            }
            self?.didTapLogin()
        }, for: .touchUpInside)
    }
    
    
    func navigateToCatalogue() {
        let tabBarViewController = MainTabBarViewController()
        tabBarViewController.userViewModel = self.userViewModel
        
        navigationController?.setViewControllers([tabBarViewController], animated: true)
    }
    
    func didTapLogin() {
        viewCustom.loginFormView.loginButton.isEnabled = false
        
        Network.loginUser(email: self.viewCustom.loginFormView.emailTextField.text!,
                          password: self.viewCustom.loginFormView.passwordTextField.text!) { data, response, error in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        if let data = data {
                            do {
                                let user = try JSONDecoder().decode(User.self, from: data)
                                self.userViewModel = UserViewModel(user: user)
                                self.userViewModel.authorization = response.value(forHTTPHeaderField: "Authorization")!
                                self.navigateToCatalogue()
                            } catch {
                                print(error)
                            }
                        }
                    }  else if response.statusCode == 401 {
                        self.didFailLogin()
                    }
                }
            }
        }
    }
    
    func didFailLogin() {
        viewCustom.loginFormView.loginButton.isEnabled = true
        viewCustom.loginFormView.emailLabel.textColor = UIColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        viewCustom.loginFormView.emailInputView.layer.borderColor = CGColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        viewCustom.loginFormView.emailTextField.textColor = UIColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        
        viewCustom.loginFormView.incorrectEmailLabel.text = "Email ou senha incorretos."
        viewCustom.loginFormView.incorrectEmailLabel.textColor = UIColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        
        viewCustom.loginFormView.passwordLabel.textColor = UIColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        viewCustom.loginFormView.passwordInputView.layer.borderColor = CGColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        viewCustom.loginFormView.passwordTextField.textColor = UIColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
    }
    
    func setupView() {
        self.viewCustom.loginFormView.changePasswordVisibility.addAction(UIAction {_ in
            self.changePasswordVisibility()
        }, for: .touchUpInside)
    }
    
    func changePasswordVisibility() {
        self.viewCustom.loginFormView.passwordTextField.isSecureTextEntry.toggle()
        
        if self.viewCustom.loginFormView.passwordTextField.isSecureTextEntry {
            self.viewCustom.loginFormView.changePasswordVisibility.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            self.viewCustom.loginFormView.changePasswordVisibility.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    func setupTextFields() {
        
        //Email
        viewCustom.loginFormView.emailTextField.addAction(UIAction {  _ in
            if self.viewCustom.loginFormView.emailTextField.hasText {
                self.showLabel(label: self.viewCustom.loginFormView.emailLabel)
            } else {
                self.hideLabel(label: self.viewCustom.loginFormView.emailLabel)
            }
        }, for: .editingChanged)
        
        //Password
        viewCustom.loginFormView.passwordTextField.addAction(UIAction {  _ in
            if self.viewCustom.loginFormView.passwordTextField.hasText {
                self.showLabel(label: self.viewCustom.loginFormView.passwordLabel)
            } else {
                self.hideLabel(label: self.viewCustom.loginFormView.passwordLabel)
            }
        }, for: .editingChanged)
    }
    
    func hideLabel(label: UILabel) {
        label.textColor = .clear
    }
    
    func showLabel(label: UILabel) {
        label.textColor = .black
    }
}


