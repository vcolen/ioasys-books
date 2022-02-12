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
    }
    
    override func loadView() {
        super.loadView()
        
        hidesBottomBarWhenPushed = true
        view = viewCustom
        setupView()
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
        
        let data : Data = "email=desafio@ioasys.com.br&password=12341234&grant_type=password".data(using: .utf8)!
        
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
                    } 
                }
            }
        }
    }
    
    func didFailLogin() {
        
    }
    
    func setupView() {
        self.viewCustom.showPasswordButton.addAction(UIAction {_ in
            self.hideShowPassword()
        }, for: .touchUpInside)
    }
    
    func hideShowPassword() {
        self.viewCustom.passwordTextField.isSecureTextEntry.toggle()
        
        if self.viewCustom.passwordTextField.isSecureTextEntry {
            self.viewCustom.showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            self.viewCustom.showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
}


