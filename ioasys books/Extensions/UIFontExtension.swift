//
//  UIFontExtension.swift
//  ioasys books
//
//  Created by Victor Colen on 09/02/22.
//

import UIKit

extension UIFont {
    static func heeboSemiBold(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "Heebo-SemiBold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func heeboMedium(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "Heebo-Medium", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func heeboLight(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "Heebo-Light", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func heebo(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "Heebo", size: size) ?? .systemFont(ofSize: size)
    }
}
