//
//  LoginViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 08/02/22.
//

import UIKit

class TestViewController: UIViewController {
    
    lazy var viewCustom = LoginView()
    var authorization = ""
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func loadView() {
        super.loadView()
        
        view = viewCustom
        setupView()
        setupTextFieldsActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewCustom.loginFormView.loginButton.addAction(UIAction { [weak self] _ in
            self?.didTapLogin()
        }, for: .touchUpInside)
    }
    
    func loginUser(completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        let postUrl = URL(string: K.URLs.auth + "/sign-in")!
        var request = URLRequest(url: postUrl)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
//        let data : Data = "email=\(self.viewCustom.emailTextField.text?.lowercased() ?? "")&password=\(self.viewCustom.passwordTextField.text ?? "")&grant_type=password".data(using: .utf8)!
        
        let data : Data = "email=desafio@ioasys.com.br&password=12341234".data(using: .utf8)!
        
        request.httpMethod = "POST"
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }.resume()
    }
    
    func navigateToCatalogue() {
        let tabBarViewController = TabBarViewController()
        tabBarViewController.authorization = self.authorization
        tabBarViewController.user = self.user
        
        navigationController?.setViewControllers([tabBarViewController], animated: true)
    }
    
    func didTapLogin() {
        loginUser { data, response, error in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        self.authorization = response.value(forHTTPHeaderField: "Authorization")!
                        if let data = data {
                            do {
                                self.user = try JSONDecoder().decode(User.self, from: data)
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
        viewCustom.loginFormView.emailLabel.textColor = UIColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        viewCustom.loginFormView.emailInputView.layer.borderColor = CGColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        viewCustom.loginFormView.emailTextField.textColor = UIColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        
        viewCustom.loginFormView.failLoginLabel.text = "Endereço de email inválido"
        viewCustom.loginFormView.failLoginLabel.textColor = UIColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        
    }
    
    func setupView() {
        self.viewCustom.loginFormView.showPasswordButton.addAction(UIAction {_ in
            self.changePasswordVisibility()
        }, for: .touchUpInside)
    }
    
    func changePasswordVisibility() {
        self.viewCustom.loginFormView.passwordTextField.isSecureTextEntry.toggle()
        
        if self.viewCustom.loginFormView.passwordTextField.isSecureTextEntry {
            self.viewCustom.loginFormView.showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            self.viewCustom.loginFormView.showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    func setupTextFieldsActions() {
        
        var showEmailLabel: Bool {
            viewCustom.loginFormView.emailTextField.hasText
        }
        
        var showPasswordLabel: Bool {
            viewCustom.loginFormView.passwordTextField.hasText
        }
        
        viewCustom.loginFormView.emailTextField.addAction(UIAction {  _ in
            if showEmailLabel {
                self.showLabel(label: self.viewCustom.loginFormView.emailLabel)
            } else {
                self.hideLabel(label: self.viewCustom.loginFormView.emailLabel)
            }
        }, for: .editingChanged)
        
        viewCustom.loginFormView.passwordTextField.addAction(UIAction {  _ in
            if showPasswordLabel {
                self.showLabel(label: self.viewCustom.loginFormView.passwordLabel)
            } else {
                self.hideLabel(label: self.viewCustom.loginFormView.passwordLabel)
            }
        }, for: .editingChanged)
        
        viewCustom.loginFormView.emailTextField.autocorrectionType = .no
        viewCustom.loginFormView.emailTextField.autocapitalizationType = .none
        
        viewCustom.loginFormView.passwordTextField.autocorrectionType = .no
        viewCustom.loginFormView.passwordTextField.autocapitalizationType = .none
    }
    
    func hideLabel(label: UILabel) {
        label.textColor = .clear
    }
    
    func showLabel(label: UILabel) {
        label.textColor = .black
    }
}


