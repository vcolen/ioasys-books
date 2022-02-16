//
//  UserModel.swift
//  ioasys books
//
//  Created by Victor Colen on 09/02/22.
//

import Foundation

struct User: Codable {
    var id: String
    var name: String
    var birthdate: String
    var gender: String
    var authorization: String?
}
