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
        bookmarkedBooks.sort { book1, book2 in
             book1.title < book2.title
         }
        self.authorization = authorization
    }
    
    func searchBookmarkedBooks(bookTitle: String, completion: @escaping ([BookViewModel]) -> Void) {
        let myBooks = BookmarkedBooks().books.values.sorted { book1, book2 in
            book1.title < book2.title
        }
        
        if bookTitle != "" {
            var fetchedBookmarkedBooks = [BookViewModel]()
            for book in myBooks {
                if book.title.localizedCaseInsensitiveContains(bookTitle) {
                    fetchedBookmarkedBooks.append(BookViewModel(book: book))
                }
            }
            completion(fetchedBookmarkedBooks)
        } else {
            completion(self.bookmarkedBooks)
        }
    }
}
