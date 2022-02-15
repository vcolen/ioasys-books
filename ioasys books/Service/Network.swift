//
//  Network.swift
//  ioasys books
//
//  Created by Victor Colen on 15/02/22.
//

import Foundation

struct Network {
    
    static func loginUser(
        email: String,
        password: String,
        completion: @escaping ((Data?, URLResponse?, Error?) -> Void)
    ) {
        let postUrl = URL(string: K.URLs.auth + "/sign-in")!
        var request = URLRequest(url: postUrl)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //        let data : Data = "email=\(email)&password=\(password)&grant_type=password".data(using: .utf8)!
        let data: Data = "email=desafio@ioasys.com.br&password=12341234".data(using: .utf8)!
        request.httpMethod = "POST"
        request.httpBody = data
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }.resume()
    }
    
    static func fetchBooks(
        authorization: String,
        completion: @escaping ((Data?, URLResponse?, Error?) -> Void)
    ) {
        let page = 1
        let url = URL(string: "https://books.ioasys.com.br/api/v1/books?page=\(page)&amount=25)")
        var getRequest = URLRequest(url: url!)
        getRequest.addValue("Bearer \(authorization)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: getRequest) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    static func fetchBooksByTitle(
        bookTitle: String,
        authorization: String,
        completion: @escaping ((Data?, URLResponse?, Error?) -> Void)
    ) {
        let urlFriendlyBookTitle = bookTitle.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = URL(string: "https://books.ioasys.com.br/api/v1/books?page=1&amount=25&title=\(urlFriendlyBookTitle!)")
        var getRequest = URLRequest(url: url!)
        getRequest.addValue("Bearer \(authorization)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: getRequest) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    
}
