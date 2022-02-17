//
//  LaunchScreenView.swift
//  ioasys books
//
//  Created by Victor Colen on 17/02/22.
//

import UIKit

class LaunchScreenView: UIView {
    
    lazy var logoView = MainLogoView()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        configureSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        addSubview(logoView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
            logoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
}
