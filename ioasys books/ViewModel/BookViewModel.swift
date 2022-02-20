//
//  BookContainerViewModel.swift
//  ioasys books
//
//  Created by Victor Colen on 15/02/22.
//

import UIKit

protocol BookViewModelProtocol {
    var title: String { get }
    var authors: String { get }
    var coverImageUrl: URL { get }
    var info: [String] { get }
    var isBookmarked: Bool { get }
    func changeBookmarkedStatus()
}

class BookViewModel: BookViewModelProtocol {
    private let book: Book
    let title: String
    let authors: String
    let coverImageUrl: URL
    let info: [String]
    var isBookmarked: Bool {
        book.isBookmarked
    }
    
    
    init(book: Book) {
        
        self.book = book
        self.title = book.title
        self.authors = book.authors.joined(separator: ", ")
        self.coverImageUrl = URL(string: book.imageUrl ?? K.Images.defaultBookCover)!
        self.info = [
            "\(book.pageCount) páginas",
            book.publisher,
           "Publicado em \(book.published)"
        ]
    }
    
    func changeBookmarkedStatus() {
        BookmarkedBooks().toggleBookmarkStatus(book: self.book)
    }
    
    func getDetailViewModelVersion() -> BookDetailViewModel {
        let bookDetailViewModel = BookDetailViewModel(of: self.book)
        return bookDetailViewModel
    }
}
