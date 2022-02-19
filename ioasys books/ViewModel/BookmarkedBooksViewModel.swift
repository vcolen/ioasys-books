//
//  BookmarkedBooksViewModel.swift
//  ioasys books
//
//  Created by Victor Colen on 19/02/22.
//

import Foundation

protocol BookmarkedBooksViewModelProtocol {
    var bookmarkedBooks: [BookViewModel] { get }
}

class BookmarkedBooksViewModel: BookmarkedBooksViewModelProtocol {
    var bookmarkedBooks = [BookViewModel]()
    
    
    init() {
        for book in BookmarkedBooks().books.values {
            self.bookmarkedBooks.append(BookViewModel(book: book))
        }
    }
    
}
