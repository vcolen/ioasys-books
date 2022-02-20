//
//  ActivityIndicatorView.swift
//  ioasys books
//
//  Created by Victor Colen on 19/02/22.
//

import UIKit

class ActivityIndicatorView: UIView {
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0.9, blue: 0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "ActivityIndicatorView.mainView"
        
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        addSubview(mainView)
        mainView.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        
        self.stretch(mainView)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
    }
    
}
