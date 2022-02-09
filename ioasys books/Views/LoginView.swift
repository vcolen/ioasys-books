//
//  LoginView.swift
//  ioasys books
//
//  Created by Victor Colen on 08/02/22.
//

import UIKit

class LoginView: UIView {
    var authorization = ""
    

    
    lazy var loginButton: UIButton = {
        let button = UIButton()
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
    }

}
