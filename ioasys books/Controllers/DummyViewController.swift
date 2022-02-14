//
//  DummyViewController.swift
//  ioasys books
//
//  Created by Victor Colen on 14/02/22.
//

import UIKit

class DummyViewController: UIViewController {
    
    let customView = ioasysLogoView()
   // let viewController = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        
        view = customView
    }
    
    func animater() {
        let centerYconstraint = NSLayoutConstraint(
            item: customView.logoStackView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: customView,
            attribute: .centerY,
            multiplier: 0.5,
            constant: 0
        )
        
        
//        UIView.animate(withDuration: 2.0) {
//
//        }
    }
}

