//
//  BookmarkedBooksViewModel.swift
//  ioasys books
//
//  Created by Victor Colen on 19/02/22.
//

import Foundation

protocol BookmarkedBooksViewModelProtocol {
    var authorization: String { get }
    var bookmarkedBooks: [BookViewModel] { get }
    func searchBookmarkedBooks(bookTitle: String, completion: @escaping ([BookViewModel]) -> Void)
}

class BookmarkedBooksViewModel: BookmarkedBooksViewModelProtocol {
    var bookmarkedBooks = [BookViewModel]()
    var authorization: String
    
    
    init(authorization: String) {
        for book in BookmarkedBooks().books.values {
            self.bookmarkedBooks.append(BookViewModel(book: book))
        }
        self.authorization = authorization
    }
    
    func searchBookmarkedBooks(bookTitle: String, completion: @escaping ([BookViewModel]) -> Void) {
        if bookTitle != "" {
            var bookmarkedBooks = [BookViewModel]()
            for book in self.bookmarkedBooks {
                if book.title.localizedCaseInsensitiveContains(bookTitle) {
                    bookmarkedBooks.append(book)
                }
            }
            completion(bookmarkedBooks)
        } else {
            completion(self.bookmarkedBooks)
        }
    }
}
