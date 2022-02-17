//
//  UIViewExtension.swift
//  ioasys books
//
//  Created by Victor Colen on 10/02/22.
//

import UIKit

// MARK: ClickListener
class ClickListener: UITapGestureRecognizer {
    var onClick : (() -> Void)? = nil
}

extension UIView {
    
    func setOnClickListener(action :@escaping () -> Void){
        let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
        tapRecogniser.onClick = action
        self.addGestureRecognizer(tapRecogniser)
    }
    
    @objc func onViewClicked(sender: ClickListener) {
        if let onClick = sender.onClick {
            onClick()
        }
    }
    
    func stretch(_ view: UIView, to otherView: UIView? = nil, top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let otherView = otherView {
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: otherView.topAnchor, constant: top),
                view.leftAnchor.constraint(equalTo: otherView.leftAnchor, constant: left),
                view.rightAnchor.constraint(equalTo: otherView.rightAnchor, constant: right),
                view.bottomAnchor.constraint(equalTo: otherView.bottomAnchor, constant: bottom)
            ])
        } else {
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: topAnchor, constant: top),
                view.leftAnchor.constraint(equalTo: leftAnchor, constant: left),
                view.rightAnchor.constraint(equalTo: rightAnchor, constant: right),
                view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom)
            ])
        }
    }
    
    func addBackground(imageName: String, contentMode: UIView.ContentMode = .scaleToFill) {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor), backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor), backgroundImageView.topAnchor.constraint(equalTo: topAnchor), backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
}
