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
    var pageCount: String { get }
    var publisher: String { get }
    var publishedDate: String { get }
    var isBookmarked: Bool { get }
}

class BookContainerViewModel: NSObject, BookContainerViewModelProtocol {
    let title: String
    let authors: String
    let coverImageUrl: URL
    let pageCount: String
    let publisher: String
    let publishedDate: String
    var isBookmarked: Bool
    
    init(book: Book) {
        self.title = book.title
        self.authors = book.authors.joined(separator: ", ")
        self.coverImageUrl = URL(string: book.imageUrl ?? "https://d2drtqy2ezsot0.cloudfront.net/Book-0.jpg")!
        self.pageCount = String(book.pageCount)
        self.publisher = book.publisher
        self.publishedDate = "Publicado em \(book.published)"
        self.isBookmarked = book.isBookmarked
    }
}
