//
//  BookContainerViewModel.swift
//  ioasys books
//
//  Created by Victor Colen on 15/02/22.
//

import Foundation
import UIKit

protocol BookContainerViewModelProtocol {
    var title: String { get }
    var authors: String { get }
    var coverImageUrl: URL { get }
    var info: [String] { get }
    var isBookmarked: Bool { get }
}

class BookContainerViewModel: BookContainerViewModelProtocol {
    let title: String
    let authors: String
    let coverImageUrl: URL
    let info: [String]
    var isBookmarked: Bool
    
    
    init(book: Book) {
        self.title = book.title
        self.authors = book.authors.joined(separator: ", ")
        self.coverImageUrl = URL(string: book.imageUrl ?? "https://d2drtqy2ezsot0.cloudfront.net/Book-0.jpg")!
        
        self.info = [
            "\(book.pageCount) páginas",
            book.publisher,
            "Publicado em \(book.published)"
        ]
        
        self.isBookmarked = book.isBookmarked
    }
}
