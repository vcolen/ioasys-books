//
//  WelcomeTitleView.swift
//  ioasys books
//
//  Created by Victor Colen on 06/02/22.
//

import UIKit

class PageDescriptionView: UIView {
    
    lazy var mainStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "PageDescriptionView.mainStackView"
        
        return stackView
    }()
    
    lazy var regularFontLabel: UILabel = {
        let label = UILabel()
        label.font = .heebo(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "PageDescriptionView.regularFontLabel"
        
       return label
    }()
    
    lazy var mediumFontLabel: UILabel = {
       let label = UILabel()
        label.font = .heeboMedium(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "PageDescriptionView.mediumFontLabel"
        
        return label
    }()
    
    func configureSubviews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(regularFontLabel)
        mainStackView.addArrangedSubview(mediumFontLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        //Main Stack View
        NSLayoutConstraint.activate([
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
}
