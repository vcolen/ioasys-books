//
//  LoginViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 08/02/22.
//

import UIKit

class LoginViewController: UIViewController {

    lazy var viewCustom = LoginFormView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //setupConstraints()
    }
    

    override func loadView() {
        super.loadView()
        
        view = viewCustom
        //view.addSubview(changeScreenButton)
        
//        NSLayoutConstraint.activate([
//            changeScreenButton.leadingAnchor.constraint(equalTo: viewCustom.leadingAnchor),
//            changeScreenButton.bottomAnchor.constraint(equalTo: viewCustom.bottomAnchor)
//        ])
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    lazy var changeScreenButton: UIButton = {
        let button = UIButton()
        button.addAction(UIAction { [weak self] _ in
            self!.changeScreen()
        },
            for: .touchUpInside)
        button.backgroundColor = .yellow
        button.setTitle("proxima tela", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()
    
    func changeScreen() {
        let newScreen = BooksViewController()
        print("apertou")
        navigationController?.pushViewController(newScreen, animated: true)
    }

}


