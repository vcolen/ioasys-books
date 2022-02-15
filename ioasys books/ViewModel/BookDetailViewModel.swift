//
//  BookDetailViewModel.swift
//  ioasys books
//
//  Created by Victor Colen on 15/02/22.
//

import Foundation

protocol BookDetailViewModelProtocol {
    var title: String { get }
    var coverImageUrl: URL { get }
    var authors: String { get }
    var info: KeyValuePairs<String, String> { get }
    var review: String { get }
}

class BookDetailViewModel: NSObject, BookDetailViewModelProtocol {
    let title: String
    let coverImageUrl: URL
    let authors: String
    let info: KeyValuePairs<String, String>
    let review: String
    
    init(of book: Book) {
        self.title = book.title
        self.coverImageUrl = URL(string: book.imageUrl ?? "https://d2drtqy2ezsot0.cloudfront.net/Book-0.jpg")!
        self.authors = book.authors.joined(separator: ", ")
        self.review = book.description
        self.info = [
            "Páginas": String(book.pageCount),
            "Editora": book.publisher,
            "Publicação": String(book.published),
            "Idioma": book.language.rawValue,
            "Título Original": book.title,
            "ISBN-10": book.isbn10,
            "ISBN-13": book.isbn13
        ]
    }
}
