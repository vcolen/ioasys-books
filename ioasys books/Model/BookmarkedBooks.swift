//
//  BookmarkedBooks.swift
//  ioasys books
//
//  Created by Victor Colen on 13/02/22.
//

import Foundation

class BookmarkedBooks {
    var books = [String : Book]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(books) {
                UserDefaults.standard.set(encoded, forKey: "Bookmarked Books")
            }
        }
    }
    
    func removeBook(book: Book) {
        self.books[book.id] = nil
    }
    
    func bookmarkBook(book: Book) {
        self.books[book.id] = book
    }
    
    func toggleBookmarkStatus(book: Book) {
        if book.isBookmarked {
            self.books[book.id] = nil
            print("desfavoritado")
        } else {
            self.books[book.id] = book
            print("favoritdado")
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Bookmarked Books") {
            if let decodedItems = try? JSONDecoder().decode([String : Book].self, from: savedItems){
                books = decodedItems
                return
            }
        }
        books = [String : Book]()
    }
}
