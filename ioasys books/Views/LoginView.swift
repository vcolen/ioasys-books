//
//  LoginView.swift
//  ioasys books
//
//  Created by Victor Colen on 08/02/22.
//

import UIKit

class LoginView: UIView {
    var authorization = ""
    func loginUser() {
        let postUrl = URL(string: "https://books.ioasys.com.br/api/v1/auth/sign-in")!
        var request = URLRequest(url: postUrl)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let data : Data = "email=desafio@ioasys.com.br&password=12341234&grant_type=password".data(using: .utf8)!
        
        request.httpMethod = "POST"
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil { print(error!) }
            if let response = response as? HTTPURLResponse {
                print(response.allHeaderFields)
                self.authorization = response.allHeaderFields["Authorization"] as! String
                print(self.authorization)
            }
        }.resume()
    }
    
    func loadData() {
        print("carregou aqui")
        let url = URL(string:"https://books.ioasys.com.br/api/v1/books?page=1")
        var getRequest = URLRequest(url: url!)
        getRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        getRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        getRequest.addValue("Bearer \(authorization)", forHTTPHeaderField: "Authorization")
        
        print(self.authorization + "essa foi a autorizacao")
      //  print(getRequest.allHTTPHeaderFields!)

        URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            if error != nil { print(error!) }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    print(response.data)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.addAction(UIAction { [weak self] _ in
            self!.loginUser()
        },
            for: .touchUpInside)
        button.backgroundColor = .yellow
        button.setTitle("alo mano sou um botao", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()
    
    lazy var getBooks: UIButton = {
        let button = UIButton()
        button.addAction(UIAction { [weak self] _ in
            self!.loadData()
        },
            for: .touchUpInside)
        button.backgroundColor = .yellow
        button.setTitle("alo mano sou um botao", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        loadViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViews() {
        addSubview(mainView)
        mainView.addSubview(loginButton)
        mainView.addSubview(getBooks)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            getBooks.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            getBooks.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }

}
