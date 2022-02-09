//
//  BookModel.swift
//  ioasys books
//
//  Created by Victor Colen on 07/02/22.
//

import Foundation


struct Response: Codable {
    let data: [Book]
    let page, totalItems, totalPages: Int
}

// MARK: - Datum
struct Book: Codable {
    let authors: [String]
    let title, description: String
    let pageCount: Int
    let category: String
    let imageURL: String?
    let language: Language
    let isbn10, isbn13, publisher: String
    let published: Int
    let id: String

    enum CodingKeys: String, CodingKey {
        case authors, title
        case description
        case pageCount, category
        case imageURL
        case language, isbn10, isbn13, publisher, published, id
    }
}

enum Language: String, Codable {
    case ingles = "Inglês"
    case português = "Português"
}

