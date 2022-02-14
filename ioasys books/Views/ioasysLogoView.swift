//
//  ioasysLogoView.swift
//  ioasys books
//
//  Created by Victor Colen on 14/02/22.
//

import UIKit

class ioasysLogoView: UIView {

    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var logoStackView: UIStackView = {
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
        addSubview(mainView)
        mainView.addSubview(logoStackView)
        logoStackView.addArrangedSubview(logoImageView)
        logoStackView.addArrangedSubview(booksLabel)
    }
    
    func setupConstraints() {
        self.stretch(mainView)
        
        NSLayoutConstraint.activate([
            logoStackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            logoStackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
    }

}
