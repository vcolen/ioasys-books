//
//  BookCatalogueViewModel.swift
//  ioasys books
//
//  Created by Victor Colen on 18/02/22.
//

import Foundation

protocol BookCatalogueViewModelProtocol {
    var authorization: String { get }
}

class BookCatalogueViewModel: BookCatalogueViewModelProtocol {
    var authorization: String
    private var books = [String : Book]()
    
    init(authorization: String) {
        self.authorization = authorization
    }
    
    func didSucceedInLogin(completion: @escaping ([BookViewModel]?, Float?, Error?) -> Void) {
        Network.fetchBooks(authorization: self.authorization) { data, response, error in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            let safeData = try JSONDecoder().decode(Response.self, from: data!)
                            let numberOfPages = safeData.totalPages
                            let books = safeData.data
                            
                            var bookContainerViewModel = [BookViewModel]()
                            for book in books {
                                self.books[book.id] = book
                                bookContainerViewModel.append(BookViewModel(book: book))
                            }
                            
                            completion(bookContainerViewModel, numberOfPages, nil)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    func loadBooksOnPage(page: Int,
                         completion: @escaping ([BookViewModel]?, Int?) -> Void
    ) {
        Network.fetchBooksWithPagination(page: page, authorization: self.authorization) { data, response, error in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            let safeData = try JSONDecoder().decode(Response.self, from: data!)
                            var books = [BookViewModel]()
                            for book in safeData.data {
                                books.append(BookViewModel(book: book))
                            }
                            completion(books, safeData.page)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    func searchBook(bookTitle: String,
                    completion: @escaping ([BookViewModel]?, Error?) -> Void
    ) {
        Network.fetchBooksByTitle(bookTitle: bookTitle, authorization: authorization) { data, response, error in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            let safeData = try JSONDecoder().decode(Response.self, from: data!)
                            var bookViewModel = [BookViewModel]()
                            for book in safeData.data {
                                bookViewModel.append(BookViewModel(book: book))
                            }
                            completion(bookViewModel, error)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
}
