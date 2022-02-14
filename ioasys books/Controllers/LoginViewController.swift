//
//  LoginViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 08/02/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var viewCustom = LoginFormView()
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
        
        viewCustom.loginButton.addAction(UIAction { [weak self] _ in
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
        
        navigationController?.pushViewController(tabBarViewController, animated: true)
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
        viewCustom.emailLabel.textColor = UIColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        viewCustom.emailInputView.layer.borderColor = CGColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        viewCustom.emailTextField.textColor = UIColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        
        viewCustom.failLoginLabel.text = "Endereço de email inválido"
        viewCustom.failLoginLabel.textColor = UIColor(red: 0.74, green: 0.31, blue: 0.31, alpha: 1.0)
        
    }
    
    func setupView() {
        self.viewCustom.showPasswordButton.addAction(UIAction {_ in
            self.changePasswordVisibility()
        }, for: .touchUpInside)
    }
    
    func changePasswordVisibility() {
        self.viewCustom.passwordTextField.isSecureTextEntry.toggle()
        
        if self.viewCustom.passwordTextField.isSecureTextEntry {
            self.viewCustom.showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            self.viewCustom.showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    func setupTextFieldsActions() {
        
        var showEmailLabel: Bool {
            viewCustom.emailTextField.hasText
        }
        
        var showPasswordLabel: Bool {
            viewCustom.passwordTextField.hasText
        }
        
        viewCustom.emailTextField.addAction(UIAction {  _ in
            if showEmailLabel {
                self.showLabel(label: self.viewCustom.emailLabel)
            } else {
                self.hideLabel(label: self.viewCustom.emailLabel)
            }
        }, for: .editingChanged)
        
        viewCustom.passwordTextField.addAction(UIAction {  _ in
            if showEmailLabel {
                self.showLabel(label: self.viewCustom.passwordLabel)
            } else {
                self.hideLabel(label: self.viewCustom.passwordLabel)
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


