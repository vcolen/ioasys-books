//
//  MainLogoView.swift
//  ioasys books
//
//  Created by Victor Colen on 14/02/22.
//

import UIKit

class MainLogoView: UIView {
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var booksLabel: UILabel = {
        let label = UILabel()
        label.text = "Books"
        label.font = .heeboLight(ofSize: 32)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(logoImageView)
        mainStackView.addArrangedSubview(booksLabel)
    }
    
    func setupConstraints() {
     
        //Main Stack View
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
