//
//  Constants.swift
//  ioasys books
//
//  Created by Victor Colen on 08/02/22.
//

import Foundation

struct K {
    struct URLs {
        static let auth = "https://books.ioasys.com.br/api/v1/auth"
        static let books = "https://books.ioasys.com.br/api/v1/books?"
    }
    
    struct Images {
        
        //Default Book Cover
        static let defaultBookCover = "https://d2drtqy2ezsot0.cloudfront.net/Book-0.jpg"
        
        //Bookmark Button
        static let isNotBookmarked = "Bookmark Icon"
        static let isBookmarked = "Bookmarked Icon"
        
        //Logo Images
        static let brightLogo = "Logo"
        static let darkLogo = "Logo Dark"
        
        //Background Image
        static let loginBackgroundImage = "Login Background"
        static let launchScreenBackground = "Launch Screen Background"
    }
}
